import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class fcm extends StatefulWidget {
  @override
  _fcmState createState() => _fcmState();
}

class _fcmState extends State<fcm> {
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();

    // Handle incoming FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received a foreground message: ${message.notification?.body}");
      setState(() {
        notifications.add(message.notification?.body ?? "No body");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: fcm(),
    );
  }
}
