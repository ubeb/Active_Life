import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/tabs/editProfile.dart';
import 'package:coba/tabs/fcm.dart';
import 'package:coba/tabs/privacyPolicy.dart';
import 'package:coba/tabs/resetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class lhoya extends StatefulWidget {
  @override
  State<lhoya> createState() => _lhoyaState();
}

class _lhoyaState extends State<lhoya> {
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

  Widget buildlhoyaPicture(String name) {
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
      radius: 50,
      backgroundColor: Colors.blue, // You can set the background color
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 40,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: AlignmentDirectional.centerStart,
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
                        return buildlhoyaPicture(userName);
                      } else {
                        return const Text("No user data found");
                      }
                    }),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'UserName',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'email',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'weight',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'height',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'gender',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                // ... (your existing code)

                SizedBox(
                  height: 20,
                ),

                // User Setting Section
                Container(
                  width: 320,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // User Setting Header
                      ListTile(
                        title: Text(
                          'User setting',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),

                      // Edit Profile
                      ListTile(
                        leading: Icon(Icons.edit),
                        title: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Handle tap for 'Edit Profile'
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileEditPage(
                                name: '',
                                age: '',
                                weight: '',
                                height: '',
                              ),
                            ),
                          );
                        },
                      ),

                      // Notifications
                      ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text(
                          'Notifications',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Handle tap for 'Notifications'
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => fcm(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // Security Setting Section
                Container(
                  width: 320,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Security Setting Header
                      ListTile(
                        title: Text(
                          'Security setting',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),

                      // Reset Password
                      ListTile(
                        leading: Icon(Icons.lock),
                        title: Text(
                          'Reset Password',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Handle tap for 'Reset Password'
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => resetPass(),
                            ),
                          );
                        },
                      ),

                      // Privacy Policy
                      ListTile(
                        leading: Icon(Icons.privacy_tip),
                        title: Text(
                          'Privacy Policy',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Handle tap for 'Privacy Policy'
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => privacy(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
