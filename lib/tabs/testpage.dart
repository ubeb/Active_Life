import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/login/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String name;
  final String email;
  final int age;
  final String gender;
  final String weight;
  final String height;

  UserModel({
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
  });
}

class testpage extends StatefulWidget {
  const testpage({Key? key}) : super(key: key);

  @override
  State<testpage> createState() => _testpageState();
}

class _testpageState extends State<testpage> {
  String userName = '';

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
      backgroundColor: Colors.blue, // You can set the background color
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
        ),
      ),
    );
  }

  final user = FirebaseAuth.instance.currentUser!;
  List<UserModel> userModels = [];

  static Future<void> logout(BuildContext context) async {
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
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
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

  @override
  void initState() {
    super.initState();
    getDocID();
  }

  Future<void> getDocID() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get();

      setState(() {
        userModels = snapshot.docs.map((doc) {
          return UserModel(
            name: doc['name'],
            email: doc['email'],
            age: doc['age'],
            gender: doc['gender'],
            weight: doc['weight'],
            height: doc['height'],
          );
        }).toList();

        if (userModels.isNotEmpty) {
          // Set the user's name
          userName = userModels[0].name;
        }
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

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
            Container(
              padding: EdgeInsets.all(16),
              alignment: AlignmentDirectional.centerStart,
              child: buildProfilePicture(
                  userModels.isNotEmpty ? userModels[0].name : ''),
            ),
            Expanded(
              child: FutureBuilder(
                future: Future.delayed(Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: userModels.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                alignment: AlignmentDirectional.centerStart,
                                child: buildProfilePicture(
                                  userModels.isNotEmpty
                                      ? userModels[0].name
                                      : '',
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: userModels.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Email: ${userModels[index].email}'),
                                          Text(
                                              'Gender: ${userModels[index].gender}'),
                                          SizedBox(height: 20),
                                          ListTile(
                                            leading: Icon(Icons.person),
                                            title: Text('Name'),
                                            subtitle: Text(userName),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.cake),
                                            title: Text('Age'),
                                            subtitle: Text(
                                                '${userModels[index].age}'),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.fitness_center),
                                            title: Text('Weight'),
                                            subtitle: Text(
                                                '${userModels[index].weight} Kg'),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.height),
                                            title: Text('Height'),
                                            subtitle: Text(
                                                '${userModels[index].height} Cm'),
                                          ),
                                          SizedBox(height: 20),
                                          GestureDetector(
                                            onTap: () => logout(context),
                                            child: Container(
                                              padding: EdgeInsets.all(16),
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              child: Text(
                                                'Logout',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
