import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/models/exercise.dart';
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
                    SizedBox(height: 35),
                    Text(
                      'Good ${_getGreeting()}, ' + user.email!,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Welcome to our workout app. Get ready to stay fit!',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
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
                height: 223,
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
                      height: 160,
                      // child: ListView.builder(
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: exercises.length,
                      //   itemBuilder: (context, index) {
                      //     return Card(
                      //       // margin: EdgeInsets.all(8),
                      //       child: Container(
                      //         width: 130,
                      //         child: Center(
                      //           child: ExerciseCard(exercise: exercises[index]),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
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
                    // Vertical ListView for workouts provided by the app
                    Container(
                      height: 200,
                      // child: ListView.builder(
                      //   itemCount: exercises.length,
                      //   itemBuilder: (context, index) {
                      //     return ExerciseCard(exercise: exercises[index]);
                      //   },
                      // ),
                    ),
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

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        width: 120,
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Image.asset(exercise.image,
        //         height: 80, width: 120, fit: BoxFit.cover),
        //     Padding(
        //       padding: EdgeInsets.all(8),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(exercise.Title,
        //               style:
        //                   TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        //           Text('Time: ${exercise.time}'),
        //           Text('Difficulty: ${exercise.difficult}',
        //               style: TextStyle(fontSize: 10)),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
