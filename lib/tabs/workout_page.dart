import 'package:coba/models/exercise_data.dart';
import 'package:coba/models/exercise_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  void createNewExercise() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('create new exercise'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //name
                  TextField(
                    controller: exerciseNameController,
                  ),
                  //weight
                  TextField(
                    controller: weightController,
                  ),
                  //reps
                  TextField(
                    controller: repsController,
                  ),
                  //sets
                  TextField(
                    controller: setsController,
                  )
                ],
              ),
              actions: [
                //save
                MaterialButton(onPressed: save, child: Text('Cancel')),
                //cancel
                MaterialButton(onPressed: cancel, child: Text('Save')),
              ],
            ));
  }

  void save() {
    String newExerciseName = exerciseNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      newExerciseName,
      weightController.text,
      repsController.text,
      setsController.text,
    );
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.workoutName),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: createNewExercise,
            child: Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: value.numberOfExerciseInWorkout(widget.workoutName),
            itemBuilder: (context, index) => ExerciseTile(
              exerciseName: value
                  .getRelevantWorkout(widget.workoutName)
                  .exercises[index]
                  .name,
              weight: value
                  .getRelevantWorkout(widget.workoutName)
                  .exercises[index]
                  .weight,
              reps: value
                  .getRelevantWorkout(widget.workoutName)
                  .exercises[index]
                  .reps,
              sets: value
                  .getRelevantWorkout(widget.workoutName)
                  .exercises[index]
                  .sets,
              isCompleted: value
                  .getRelevantWorkout(widget.workoutName)
                  .exercises[index]
                  .isCompleted,
              onCheckboxChanged: (val) => onCheckBoxChanged(
                widget.workoutName,
                value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name,
              ),
            ),
          )),
    );
  }
}
