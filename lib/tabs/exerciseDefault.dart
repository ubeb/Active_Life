import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class myexercise extends StatelessWidget {
  final String workoutDifficulty;
  final String workoutId;
  final String exerciseId;

  const myexercise({
    required this.workoutDifficulty,
    required this.workoutId,
    required this.exerciseId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 28, 30),
        centerTitle: true,
        title: Text(
          'Exercise Details',
          style: TextStyle(
            color: Color.fromARGB(
              255,
              208,
              253,
              62,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var doc = snapshot.data as DocumentSnapshot<Map<String, dynamic>>;
          if (doc.exists) {
            // The document exists, you can access its data
            var workoutData = doc.data();
            var exercises = workoutData?['exercises'] as List<dynamic>;
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }

  Future<Map<String, dynamic>> _fetchExerciseDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> workoutSnapshot =
          await FirebaseFirestore.instance
              .collection('Workout Collection')
              .doc('Recommended Workouts')
              .collection(workoutDifficulty)
              .doc(workoutId)
              .get();

      if (workoutSnapshot.exists) {
        var exercises = workoutSnapshot.data()?['exercises'] as List<dynamic>;

        // Find the exercise by exerciseId
        var exercise = exercises.firstWhere(
          (element) => element['exerciseId'] == exerciseId,
          orElse: () => null,
        );

        if (exercise != null) {
          return exercise as Map<String, dynamic>;
        } else {
          throw 'Exercise not found';
        }
      } else {
        throw 'Workout not found';
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Widget _buildExerciseDetails(Map<String, dynamic> exerciseDetails) {
    return Container(
      color: Color.fromARGB(255, 28, 28, 30),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exercise Name: ${exerciseDetails['exercise name'] ?? ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Weights: ${exerciseDetails['weights'] ?? ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            'Reps: ${exerciseDetails['reps'] ?? ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            'Sets: ${exerciseDetails['sets'] ?? ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            'Duration: ${exerciseDetails['duration'] ?? ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          // Add more details if needed
        ],
      ),
    );
  }
}
