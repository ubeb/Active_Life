import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class fcm extends StatefulWidget {
  @override
  _fcmState createState() => _fcmState();
}

class _fcmState extends State<fcm> {
  SharedPreferences? _prefs;
  List<Map<String, String>> notifications = [];
  bool _mounted = false;

  String _formatTimestamp(Timestamp timestamp) {
    final formattedDate = DateFormat.Hm().format(timestamp.toDate());
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });
    _mounted = true;

    // Handle incoming fcm messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received a foreground message: ${message.notification?.body}");
      if (_mounted) {
        setState(() {
          notifications.add({
            'title': message.notification?.title ?? "No title",
            'body': message.notification?.body ?? "No body",
            'timestamp': DateTime.now().toString(),
          });
        });

        // Store the notification locally
        _storeNotificationLocally(message.notification);
        // Store the notification in Firestore and update the document ID in the list
        _storeNotificationInFirestore(message.notification);
      }
    });
  }

  void _storeNotificationLocally(RemoteNotification? notification) {
    if (_prefs != null && notification != null) {
      final localNotifications =
          _prefs!.getStringList('localNotifications') ?? [];

      localNotifications.add(notification.title ?? "No title");
      localNotifications.add(notification.body ?? "No body");
      localNotifications.add(DateTime.now().toString());

      _prefs!.setStringList('localNotifications', localNotifications);
    }
  }

  void deleteNotification(int index) async {
    if (_mounted && index >= 0 && index < notifications.length) {
      final documentId = notifications[index]['documentId'];

      print(
          'Deleting notification at index $index with documentId: $documentId');

      if (documentId != null && documentId.isNotEmpty) {
        try {
          // Delete the notification from Firestore
          await FirebaseFirestore.instance
              .collection('notifications')
              .doc(documentId)
              .delete();

          print('Notification deleted successfully from Firestore.');

          // Update the UI to reflect the deletion
          setState(() {
            notifications.removeAt(index);
          });

          print('UI updated after notification deletion.');
        } catch (e) {
          print('Error deleting notification from Firestore: $e');
        }
      } else {
        print('Invalid documentId for notification at index $index');
      }
    }
  }

  Future<void> _storeNotificationInFirestore(
      RemoteNotification? notification) async {
    if (notification != null) {
      try {
        final docRef =
            await FirebaseFirestore.instance.collection('notifications').add({
          'title': notification.title,
          'body': notification.body,
          'timestamp': DateTime.now(),
        });

        // Update the document ID in the list
        if (_mounted) {
          setState(() {
            final index = notifications.length - 1;
            notifications[index] = {
              'title': notification.title ?? "No title",
              'body': notification.body ?? "No body",
              'timestamp':
                  DateTime.now().toString(), // Convert Timestamp to DateTime
              'documentId': docRef.id,
            };
          });
        }
      } catch (e) {
        print("Error storing notification in Firestore: $e");
      }
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Color.fromARGB(
              255,
              208,
              253,
              62,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 28, 28, 30),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('notifications').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Container(
                color: Color.fromARGB(255, 28, 28, 30),
                child: Center(
                  child: Text(
                    'No notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else {
              var notifications = snapshot.data!.docs;

              return Container(
                color: Color.fromARGB(255, 28, 28, 30),
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    var notificationData =
                        notifications[index].data() as Map<String, dynamic>;
                    return Container(
                      color: Color.fromARGB(255, 28, 28, 30),
                      height: 90,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                notificationData['title'] ?? "No title",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 28, 28, 30)),
                              ),
                              // Corrected line without the 'final' keyword
                              Text(
                                _formatTimestamp(
                                    notificationData['timestamp'] as Timestamp),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[800]),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6),
                              Text(
                                notificationData['body'] ?? "No body",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 28, 28, 30)),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteNotification(index),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
