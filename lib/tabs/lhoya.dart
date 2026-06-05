import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void addWorkoutCollection() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Recommended Workouts
  await addDifficultyLevel(
    firestore,
    'recommendedWorkouts',
    'Beginner',
    [
      {
        'name': 'Bodyweight Squats',
        'weight': 'Body Weight',
        'reps': 15,
        'sets': 3,
        'duration': null,
      },
      {
        'name': 'Push-ups',
        'weight': 'Body Weight',
        'reps': 12,
        'sets': 3,
        'duration': null,
      },
      {
        'name': 'Walking Lunges',
        'weight': 'Body Weight',
        'reps': 10,
        'sets': 3,
        'duration': null,
      },
      {
        'name': 'Plank',
        'weight': 'Body Weight',
        'reps': null,
        'sets': 3,
        'duration': 30,
      },
    ],
  );

  await addDifficultyLevel(
    firestore,
    'recommendedWorkouts',
    'Intermediate',
    [
      {
        'name': 'Goblet Squats',
        'weight': '20 lbs (dumbbell)',
        'reps': 12,
        'sets': 4,
        'duration': null,
      },
      {
        'name': 'Push-ups (Diamond)',
        'weight': 'Body Weight',
        'reps': 15,
        'sets': 4,
        'duration': null,
      },
      {
        'name': 'Bulgarian Split Squats',
        'weight': 'Body Weight',
        'reps': 10,
        'sets': 4,
        'duration': null,
      },
      {
        'name': 'Plank to Shoulder Tap',
        'weight': 'Body Weight',
        'reps': null,
        'sets': 4,
        'duration': 45,
      },
    ],
  );

  await addDifficultyLevel(
    firestore,
    'recommendedWorkouts',
    'Advanced',
    [
      {
        'name': 'Barbell Squats',
        'weight': '135 lbs',
        'reps': 8,
        'sets': 5,
        'duration': null,
      },
      {
        'name': 'Overhead Press',
        'weight': '95 lbs (barbell)',
        'reps': 6,
        'sets': 5,
        'duration': null,
      },
      {
        'name': 'Weighted Pull-ups',
        'weight': '20 lbs (weight belt)',
        'reps': 8,
        'sets': 5,
        'duration': null,
      },
      {
        'name': 'Barbell Lunges',
        'weight': '95 lbs',
        'reps': 10,
        'sets': 5,
        'duration': null,
      },
    ],
  );
//avbdhtcgniwabeonchmrctfudsggdasjdghghfkyugakjhasjchbkueficugnywwocriuwueunoencwqoiemcnqowyicnqwoeimncrwfxnxqeimpocnfrx
  // Default Workouts
  await addDifficultyLevel(
    firestore,
    'defaultWorkouts',
    'Beginner',
    [
      {
        'name': 'Bodyweight Squats',
        'weight': 'Body Weight',
        'reps': 15,
        'sets': 3,
        'duration': null,
      },
      {
        'name': 'Push-ups',
        'weight': 'Body Weight',
        'reps': 12,
        'sets': 3,
        'duration': null,
      },
      {
        'name': 'Walking Lunges',
        'weight': 'Body Weight',
        'reps': 10,
        'sets': 3,
        'duration': null,
      },
      {
        'name': 'Plank',
        'weight': 'Body Weight',
        'reps': null,
        'sets': 3,
        'duration': 30,
      },
      {
        'name': 'Modified Push-ups',
        'weight': 'Body Weight',
        'reps': 12,
        'sets': 3,
        'duration': null,
      },
      {
        'name': 'Chair Squats',
        'weight': 'Body Weight',
        'reps': 15,
        'sets': 3,
        'duration': null,
      },
      {
        'name': 'Knee Plank',
        'weight': 'Body Weight',
        'reps': null,
        'sets': 3,
        'duration': 30,
      },
      // Add more exercises as needed
    ],
  );

  await addDifficultyLevel(
    firestore,
    'defaultWorkouts',
    'Intermediate',
    [
      {
        'name': 'Goblet Squats',
        'weight': '20 lbs (dumbbell)',
        'reps': 12,
        'sets': 4,
        'duration': null,
      },
      {
        'name': 'Push-ups (Diamond)',
        'weight': 'Body Weight',
        'reps': 15,
        'sets': 4,
        'duration': null,
      },
      {
        'name': 'Bulgarian Split Squats',
        'weight': 'Body Weight',
        'reps': 10,
        'sets': 4,
        'duration': null,
      },
      {
        'name': 'Plank to Shoulder Tap',
        'weight': 'Body Weight',
        'reps': null,
        'sets': 4,
        'duration': 45,
      },
      {
        'name': 'Dumbbell Bench Press',
        'weight': '25 lbs (each dumbbell)',
        'reps': 10,
        'sets': 4,
        'duration': null,
      },
      {
        'name': 'Dumbbell Rows',
        'weight': '20 lbs (each dumbbell)',
        'reps': 12,
        'sets': 4,
        'duration': null,
      },
      {
        'name': 'Jump Squats',
        'weight': 'Body Weight',
        'reps': 10,
        'sets': 4,
        'duration': null,
      },
      // Add more exercises as needed
    ],
  );

  await addDifficultyLevel(
    firestore,
    'defaultWorkouts',
    'Advanced',
    [
      {
        'name': 'Barbell Squats',
        'weight': '135 lbs',
        'reps': 8,
        'sets': 5,
        'duration': null,
      },
      {
        'name': 'Overhead Press',
        'weight': '95 lbs (barbell)',
        'reps': 6,
        'sets': 5,
        'duration': null,
      },
      {
        'name': 'Weighted Pull-ups',
        'weight': '20 lbs (weight belt)',
        'reps': 8,
        'sets': 5,
        'duration': null,
      },
      {
        'name': 'Barbell Lunges',
        'weight': '95 lbs',
        'reps': 10,
        'sets': 5,
        'duration': null,
      },
      {
        'name': 'Deadlifts',
        'weight': '185 lbs',
        'reps': 8,
        'sets': 5,
        'duration': null,
      },
      {
        'name': 'Pull-ups',
        'weight': 'Body Weight',
        'reps': 10,
        'sets': 5,
        'duration': null,
      },
      {
        'name': 'Barbell Lunges',
        'weight': '115 lbs',
        'reps': 12,
        'sets': 5,
        'duration': null,
      },
    ],
  );
}

Future<void> addDifficultyLevel(FirebaseFirestore firestore, String category,
    String difficulty, List<Map<String, dynamic>> exercises) async {
  await firestore
      .collection('workoutCollection')
      .doc(category)
      .collection(difficulty)
      .doc('workout')
      .set({
    'name': '$difficulty Workout',
    'exercises': exercises,
  });
}

void main() {
  runApp(lhohe());
}

class lhohe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firestore Workout Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Call the function when the button is pressed
                  addWorkoutCollection();
                },
                child: Text('Add Workout Collection'),
              ),
              SizedBox(height: 20), // Add some spacing
              ElevatedButton(
                onPressed: () {
                  // Call the function when the button is pressed
                  addWorkoutCollection();
                },
                child: Text('Add Workout Collection Again'),
              ),
              // Add other widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}
