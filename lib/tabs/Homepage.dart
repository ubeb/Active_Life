// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/models/defaultexercise.dart';
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
  List<String> docId = [];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabControllerProvider()),
      ],
      child: Scaffold(
        body: Container(
          color: Color.fromARGB(255, 28, 28, 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Section
                Container(
                  padding: EdgeInsets.all(16),
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
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                  'Something went wrong',
                                  style: TextStyle(color: Colors.white),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
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
                                              color: Color.fromARGB(
                                                255,
                                                208,
                                                253,
                                                62,
                                              )),
                                        ),
                                        Text(
                                          snapshot.data!.docs.first['name'],
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                255,
                                                208,
                                                253,
                                                62,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return Text(
                                  'No data found2',
                                  style: TextStyle(color: Colors.white),
                                );
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
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Replaced with a useful button to start a workout
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(
                            255,
                            208,
                            253,
                            62,
                          ),
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          // Add your logic for starting a workout here
                          Provider.of<TabControllerProvider>(context,
                                  listen: false)
                              .changeTab(1); // Switch to the "workout" tab
                        },
                        child: Text('Start a Workout',
                            style: TextStyle(
                                color: Color.fromARGB(255, 28, 28, 30))),
                      ),
                    ],
                  ),
                ),
                // Middle Section
                Container(
                  height: 283,
                  color: Color.fromARGB(255, 28, 28, 30),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recommended Workouts',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(
                              255,
                              208,
                              253,
                              62,
                            )),
                      ),
                      SizedBox(height: 8),
                      // Horizontal ListView for recommended workout programs
                      Container(
                        height: 220,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('workoutCollection')
                              .doc('defaultWorkouts')
                              .collection('Beginner')
                              .doc('workout')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("Loading...");
                            }
                            var doc = snapshot.data
                                as DocumentSnapshot<Map<String, dynamic>>;
                            if (doc.exists) {
                              var workoutData = doc.data();
                              var exercises =
                                  workoutData?['exercises'] as List<dynamic>;
                              return ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: exercises.map((exercise) {
                                  ExerciseDetails details = ExerciseDetails(
                                    name: exercise['name'] ?? 'Exercise Name',
                                    weight: exercise['weight'] ?? '',
                                    reps: exercise['reps'] ?? 0,
                                    sets: exercise['sets'] ?? 0,
                                    duration: exercise['duration'] ?? 0,
                                  );
                                  return Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            details.name,
                                            style: const TextStyle(
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
                                  );
                                }).toList(),
                              );
                            } else {
                              return const Text(
                                "No workouts available",
                                style: TextStyle(color: Colors.white),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Bottom Section
                Container(
                  color: Color.fromARGB(255, 28, 28, 30),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Workouts Provided by the App',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(
                              255,
                              208,
                              253,
                              62,
                            )),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 220,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('workoutCollection')
                              .doc('defaultWorkouts')
                              .collection('Beginner')
                              .doc('workout')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            var doc = snapshot.data
                                as DocumentSnapshot<Map<String, dynamic>>;
                            if (doc.exists) {
                              // The document exists, you can access its data
                              var workoutData = doc.data();
                              var exercises =
                                  workoutData?['exercises'] as List<dynamic>;
                              return ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                children: exercises.map((exercise) {
                                  return Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            exercise['name'] ?? 'Exercise Name',
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
                                  );
                                }).toList(),
                              );
                            } else {
                              // Document does not exist
                              return Text("No provided workouts available");
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
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
