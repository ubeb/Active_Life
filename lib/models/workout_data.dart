import 'package:coba/models/exercise.dart';
import 'package:flutter/material.dart';
import 'workout.dart';

class WorkoutData extends ChangeNotifier {
  List<Workout> workoutList = [
    //default workout
    Workout(
      name: 'Upper Body',
      exercises: [
        Exercise(
          name: 'bicep curl',
          weight: '10',
          reps: '10',
          sets: '3',
        ),
      ],
    ),
    Workout(
      name: 'Lower Body',
      exercises: [
        Exercise(
          name: 'Squads',
          weight: '10',
          reps: '10',
          sets: '3',
        ),
      ],
    ),
  ];

  int numberOfExerciseInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  //add exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets,
      {required bool isCompleted}) {
    //find workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    //add exercise to workout
    relevantWorkout.exercises.add(
      Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
      ),
    );
    notifyListeners();
  }

  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  Exercise getExerciseTerkait(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }

  void deleteWorkout(int index) {
    if (index >= 0 && index < workoutList.length) {
      workoutList.removeAt(index);
      notifyListeners();
    }
  }
}
