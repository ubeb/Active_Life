import 'package:coba/models/exercise.dart';

class ExerciseRepository {
  // Mengganti nama class ItemRepository menjadi ExerciseRepository
  List<Exercise> exercises = [];

  void addExercise(Exercise exercise) {
    // Mengganti addItem menjadi addExercise
    exercises.add(exercise);
  }

  List<Exercise> getAllExercises() {
    // Mengganti getAllItems menjadi getAllExercises
    return exercises;
  }

  void updateExercise(Exercise exercise) {
    // Mengganti updateItem menjadi updateExercise
    // Implement update logic here
    exercises[exercises
            .indexWhere((element) => element.Title == exercise.Title)] =
        exercise; // Mengganti item menjadi exercise
  }

  void deleteExercise(Exercise exercise) {
    // Mengganti deleteItem menjadi deleteExercise
    exercises.remove(exercise);
  }
}
