import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/login/loginPage.dart';
import 'package:coba/tabs/editProfile.dart';
import 'package:coba/tabs/fcm.dart';
import 'package:coba/tabs/privacyPolicy.dart';
import 'package:coba/tabs/resetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final user = FirebaseAuth.instance.currentUser!;
  final userName = FirebaseFirestore.instance.collection('users').snapshots();
  late String userNameE = "";
  late String userEmail = "";

  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 28, 28, 30),
          title: Text(
            "Logout",
            style: TextStyle(
                color: Color.fromARGB(
              255,
              208,
              253,
              62,
            )),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildprofilePicture(String name, String gender) {
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
      radius: 40,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  void fetchUserData() async {
    // Assuming 'users' is the collection name and 'name', 'email', and 'gender' are fields in your document
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        userNameE = userDoc['name'];
        userEmail = userDoc['email'];
        String userGender = userDoc[
            'gender']; // Assuming 'gender' is the field representing the user's gender
        buildprofilePicture(userNameE, userGender);
      });
    } else {
      print('User document does not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Profile',
            style: TextStyle(
                color: Color.fromARGB(
              255,
              208,
              253,
              62,
            ))),
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 28, 28, 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading...");
                        }
                        var docs = snapshot.data!.docs;
                        if (docs.isNotEmpty) {
                          String userNameE = docs.first['name'];
                          return buildprofilePicture(userNameE, 'Perempuan');
                        } else {
                          return const Text("No user data found");
                        }
                      }),
                    ),
                  ),
                  Column(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('uid', isEqualTo: user.uid)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                              'Something went wrong',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.docs.first['name'],
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(
                                        255,
                                        208,
                                        253,
                                        62,
                                      )),
                                ),
                                Text(
                                  snapshot.data!.docs.first['email'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                )
                              ],
                            );
                          } else {
                            return Text('No data found2');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('uid', isEqualTo: user.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Weight',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  snapshot.data!.docs.first['weight']
                                          .toString() +
                                      ' kg',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color:
                                          Color.fromARGB(255, 123, 123, 123)),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Height',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  snapshot.data!.docs.first['height']
                                          .toString() +
                                      ' cm',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color:
                                          Color.fromARGB(255, 123, 123, 123)),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Age',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  snapshot.data!.docs.first['age'].toString() +
                                      ' y/o',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color:
                                          Color.fromARGB(255, 123, 123, 123)),
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        return Text('No data found2');
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    width: 320,
                    height: 180,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'User setting',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.edit),
                          title: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .where('uid', isEqualTo: user.uid)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    if (snapshot.hasData) {
                                      final name =
                                          snapshot.data!.docs.first['name'];
                                      final email =
                                          snapshot.data!.docs.first['email'];
                                      return ProfileEditPage(
                                          name: name, email: email);
                                    } else {
                                      return Text('No data found');
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text(
                            'Notifications',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
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
                  Container(
                    width: 320,
                    height: 180,
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
                        ListTile(
                          title: Text(
                            'Security setting',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.lock),
                          title: Text(
                            'Change Password',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => resetpass(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.privacy_tip),
                          title: Text(
                            'Privacy Policy',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
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
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 320,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 28, 28, 30),
                      border: Border.all(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          'logout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () => logout(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'version 1.0.0',
                    style: TextStyle(
                        color: Color.fromARGB(
                      255,
                      208,
                      253,
                      62,
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
