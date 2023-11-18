import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/tabs/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final user = FirebaseAuth.instance.currentUser!;
  final recomWork =
      FirebaseFirestore.instance.collection('recomWork').snapshots();
  final appWork = FirebaseFirestore.instance.collection('appWork').snapshots();

  List<String> docId = [];

  Future getDocIdRecom() async {
    await FirebaseFirestore.instance
        .collection('recomWork')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docId.add(document.reference.id);
            }));
  }

  Future getDocIdApp() async {
    await FirebaseFirestore.instance
        .collection('appWork')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docId.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TabControllerProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top Section
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
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
                              return Text('Something went wrong');
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
                                  Row(
                                    children: [
                                      Text(
                                        'Good ${_getGreeting()}, ',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        snapshot.data!.docs.first['name'],
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Text('No data found2');
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome to our workout app. Get ready to stay fit!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Replaced with a useful button to start a workout
                    ElevatedButton(
                      onPressed: () {
                        // Add your logic for starting a workout here
                        print('Start a workout button pressed!');
                      },
                      child: Text('Start a Workout'),
                    ),
                  ],
                ),
              ),
              // Middle Section
              Container(
                height: 283,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended Workouts',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    // Horizontal ListView for recommended workout programs
                    Container(
                      height: 220,
                      width: 300,
                      alignment: FractionalOffset.topCenter,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('recomWork')
                            .orderBy('createdAt', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading...");
                          }
                          var docs = snapshot.data!.docs;
                          if (docs.isNotEmpty) {
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              docs[index]['name'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                              ),
                                              onPressed: () => (),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            );
                          } else {
                            return const Text(
                                "No recommended workouts available");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              // Bottom Section
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Workouts Provided by the App',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 200,
                      width: 300,
                      alignment: FractionalOffset.topCenter,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('appWork')
                            .orderBy('createdAt', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading...");
                          }
                          var docs = snapshot.data!.docs;
                          if (docs.isNotEmpty) {
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              docs[index]['name'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                              ),
                                              onPressed: () => (),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            );
                          } else {
                            return const Text(
                                "No recommended workouts available");
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 6) {
      return 'Night';
    } else if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }
}
