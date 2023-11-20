import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/models/defaultexercise.dart';
import 'package:coba/tabs/crud.dart';
import 'package:coba/tabs/exerciseDefault.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  void _goToExerciseDetails(String workoutDifficulty, List<dynamic> exercises,
      int selectedExerciseIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => myexercise(
          workoutDifficulty: workoutDifficulty,
          workoutExercises: exercises,
          selectedExerciseIndex: selectedExerciseIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 28, 28, 30),
          title: const Text(
            'Workout Plans',
            style: TextStyle(
              color: Color.fromARGB(
                255,
                208,
                253,
                62,
              ),
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(255, 208, 253, 62),
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
        color: Color.fromARGB(255, 28, 28, 30),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Text('$difficulty Workouts',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            SizedBox(
              height: 8,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('workoutCollection')
                  .doc('defaultWorkouts')
                  .collection(difficulty)
                  .doc('workout')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var doc =
                    snapshot.data as DocumentSnapshot<Map<String, dynamic>>;
                if (doc.exists) {
                  var workoutData = doc.data();
                  var exercises = workoutData?['exercises'] as List<dynamic>;

                  // Sort exercises by name
                  exercises.sort(
                      (a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));

                  return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: exercises.asMap().entries.map((entry) {
                      var index = entry.key;
                      var exercise = entry.value;

                      ExerciseDetails details = ExerciseDetails(
                        name: exercise['name'] ?? 'Exercise Name',
                        weight: exercise['weight'] ?? '',
                        reps: exercise['reps'] ?? 0,
                        sets: exercise['sets'] ?? 0,
                        duration: exercise['duration'] ?? 0,
                      );

                      return GestureDetector(
                        onTap: () {
                          _goToExerciseDetails(
                            difficulty,
                            exercises,
                            index,
                          );
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ],
        ),
      ),
    );
  }

  // Method for the Custom tab
  Widget _buildCustomTab() {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromARGB(255, 28, 28, 30),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text('Custom Workouts',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            // Add your custom content here, e.g., text and button
            SizedBox(
              height: 10,
            ),
            const Text(
              'Create your custom workout here.',
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 208, 253, 62)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return crud();
                }));
              },
              child: const Text(
                "Create Workout",
                style: TextStyle(color: Color.fromARGB(255, 28, 28, 30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
