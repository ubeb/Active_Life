import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  final userName = FirebaseFirestore.instance.collection('users').snapshots();

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

  Widget buildProfilePicture(String name) {
    String initials = '';
    if (name.isNotEmpty) {
      List<String> nameSplit = name.split(' ');
      if (nameSplit.length > 0) {
        initials += nameSplit[0][0];
        if (nameSplit.length > 1) {
          initials += nameSplit[1][0];
        }
      }
    }

    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.blue,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Top Section
          Expanded(
            child: Row(
              children: [
                // Left Section (Initial Avatar)
                Container(
                  padding: EdgeInsets.all(16),
                  child: StreamBuilder(
                    stream: userName,
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading...");
                      }
                      var docs = snapshot.data!.docs;
                      if (docs.isNotEmpty) {
                        // Assuming 'name' is the field in Firestore containing the user's name
                        String userName = docs.first['name'];
                        return buildProfilePicture(userName);
                      } else {
                        return const Text("No user data found");
                      }
                    }),
                  ),
                ),
                // Right Section (User Data)
                Expanded(
                  child: StreamBuilder(
                    stream: userName,
                    builder: ((context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading...");
                      }
                      var docs = snapshot.data!.docs;
                      if (docs.isNotEmpty) {
                        // Assuming 'name' is the field in Firestore containing the user's name
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${docs[0]['name']}'),
                            Text('email: ${docs[0]['email']}'),
                            Text('gender: ${docs[0]['gender']}'),
                            Text('age: ${docs[0]['age']}'),
                            Text('weight: ${docs[0]['weight']}'),
                            Text('height: ${docs[0]['height']}'),
                          ],
                        );
                      } else {
                        return const Text("No user data found");
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Section (Add any widgets you want in the bottom section)
          Container(
            padding: EdgeInsets.all(16),
            child: Text('This is the bottom section'),
          ),
        ],
      ),
    );
  }
}
