import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/models/workout_data.dart';
import 'package:coba/models/exercise_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatefulWidget {
  final String workoutName;
  final String workoutDocumentId;
  const ExercisePage(
      {super.key, required this.workoutName, required this.workoutDocumentId});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  void onCheckBoxChanged(String exerciseId, bool isChecked) async {
    await FirebaseFirestore.instance
        .collection('workouts')
        .doc(widget.workoutDocumentId)
        .collection('exercises')
        .doc(exerciseId)
        .update({
      'isCompleted': isChecked,
    });
    checkAllExercisesCompleted();
    // Refresh the UI
    setState(() {});
  }

  Future<void> checkAllExercisesCompleted() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('workouts')
        .doc(widget.workoutDocumentId)
        .collection('exercises')
        .get();

    // Check if the snapshot has data
    if (snapshot.docs.isNotEmpty) {
      bool allExercisesCompleted = snapshot.docs.every(
        (doc) {
          var data = doc.data() as Map<String, dynamic>?;

          return data != null &&
              data['isCompleted'] != null &&
              data['isCompleted'];
        },
      );

      // Update workout's isCompleted value
      await FirebaseFirestore.instance
          .collection('workouts')
          .doc(widget.workoutDocumentId)
          .update({
        'isCompleted': allExercisesCompleted,
      });

      // Refresh the UI
      setState(() {});
    }
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
                    style: TextStyle(
                      color: Color.fromARGB(255, 128, 128, 128),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Exercise Name",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  //weight
                  TextField(
                    controller: weightController,
                    style: TextStyle(
                      color: Color.fromARGB(255, 128, 128, 128),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Weight",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  //reps
                  TextField(
                    controller: repsController,
                    style: TextStyle(
                      color: Color.fromARGB(255, 128, 128, 128),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Reps",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  //sets
                  TextField(
                    controller: setsController,
                    style: TextStyle(
                      color: Color.fromARGB(255, 128, 128, 128),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Sets",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  )
                ],
              ),
              actions: [
                //save
                MaterialButton(onPressed: cancel, child: Text('Cancel')),
                //cancel
                MaterialButton(onPressed: save, child: Text('Save')),
              ],
            ));
  }

  void save() async {
    String newExerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;

    await FirebaseFirestore.instance
        .collection('workouts')
        .doc(widget.workoutDocumentId)
        .collection('exercises')
        .add({
      'exerciseName': newExerciseName,
      'weight': weight,
      'sets': sets,
      'reps': reps,
      'isCompleted': false,
    });

    Navigator.pop(context); // Menutup dialog
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
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('workouts')
              .doc(widget.workoutDocumentId)
              .collection('exercises')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            var exercises = snapshot.data!.docs;
            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                var exerciseData =
                    exercises[index].data() as Map<String, dynamic>;
                return ExerciseTile(
                  exerciseName: exerciseData['exerciseName'] ?? '',
                  weight: exerciseData['weight'] ?? '',
                  reps: exerciseData['reps'] ?? '',
                  sets: exerciseData['sets'] ?? '',
                  isCompleted: exerciseData['isCompleted'] ?? false,
                  onCheckboxChanged: (val) {
                    onCheckBoxChanged(exercises[index].id, val);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
