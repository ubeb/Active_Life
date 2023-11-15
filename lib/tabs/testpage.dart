import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/getUserName.dart';

class testpage extends StatefulWidget {
  const testpage({super.key});

  @override
  State<testpage> createState() => _testpageState();
}

class _testpageState extends State<testpage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Logout"),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Call getDocID in initState to ensure it's called only once when the widget is created
    getDocID();
  }

  Future<void> getDocID() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid',
              isEqualTo: user.uid) // Filter documents with the same UID
          .get();

      setState(() {
        docIDs = snapshot.docs.map((doc) => doc.id).toList();
      });
    } catch (e) {
      // Handle any potential errors here
      print("Error fetching document IDs: $e");
    }
  }

  // ... Rest of the code remains unchanged

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/image009.jpg'),
            ),
            Expanded(
              child: FutureBuilder(
                // Use a Future.delayed to simulate a delay (for testing purposes)
                future: Future.delayed(Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: GetuserName(documentId: docIDs[index]),
                        );
                      },
                    );
                  } else {
                    // Return a loading indicator or an empty container while waiting
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
