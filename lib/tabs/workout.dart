import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/tabs/exercise_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  final user = FirebaseAuth.instance.currentUser!;
  final appWork =
      FirebaseFirestore.instance.collection('workoutCollection').snapshots();
  List<String> docId = [];
  void goToExercisePage(String workoutName, String workoutDocumentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExercisePage(
          workoutName: workoutName,
          workoutDocumentId: workoutDocumentId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Workout Plans'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Beginner'),
              Tab(text: 'Intermediate'),
              Tab(text: 'Advanced'),
              Tab(text: 'Custom'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildWorkoutList('Beginner'),
            _buildWorkoutList('Intermediate'),
            _buildWorkoutList('Advanced'),
            _buildCustomTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutList(String difficulty) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Text('$difficulty Workouts', style: const TextStyle(fontSize: 20)),
            Container(
              height: 260,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('workoutCollection')
                    .doc('recommendedWorkouts')
                    .collection(difficulty)
                    .doc('workout')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...");
                  }
                  var doc =
                      snapshot.data as DocumentSnapshot<Map<String, dynamic>>;
                  if (doc.exists) {
                    var workoutData = doc.data();
                    var exercises = workoutData?['exercises'] as List<dynamic>;

                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: exercises.map((exercise) {
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Text(
                              exercise['name'] ?? 'Exercise Name',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return const Text("No recommended workouts available");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method for the Custom tab
  Widget _buildCustomTab() {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Text('Custom Workouts', style: const TextStyle(fontSize: 20)),
            // Add your custom content here, e.g., text and button
            const Text('Your custom workout content goes here.'),
            ElevatedButton(
              onPressed: () {
                // Handle button click for custom action
              },
              child: const Text("Custom Action"),
            ),
          ],
        ),
      ),
    );
  }
}
