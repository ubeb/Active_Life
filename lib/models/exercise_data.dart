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

  //get list
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  int numberOfExerciseInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  //add workout
  void addWorkout(String name) {
    //add workout to list with blank exercises
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
  }

  //add exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
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

  //check off workout
  void checkOffExercise(String workoutName, String exerciseName) {
    // not sure how to do this
    Exercise relevantExercise = getExerciseTerkait(workoutName, exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;
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
  //get length of workout
}
