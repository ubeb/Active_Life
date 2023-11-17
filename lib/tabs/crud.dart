import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:coba/models/workout_data.dart';
import 'package:coba/tabs/exercise_page.dart';

class crud extends StatefulWidget {
  const crud({Key? key}) : super(key: key);

  @override
  State<crud> createState() => _crudState();
}

class _crudState extends State<crud> {
  final newWorkoutNameController = TextEditingController();

  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New Workout'),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          MaterialButton(onPressed: cancel, child: Text('Cancel')),
          MaterialButton(onPressed: save, child: Text('Save')),
        ],
      ),
    );
  }

  void save() async {
    String newWorkoutName = newWorkoutNameController.text;

    // Membuat dokumen baru dalam koleksi 'workouts'
    DocumentReference workoutReference = await FirebaseFirestore.instance
        .collection('workouts')
        .add({'name': newWorkoutName, 'isCompleted': false});

    // Menentukan ID dokumen untuk latihan
    String workoutDocumentId = workoutReference.id;

    // Menambahkan koleksi baru bernama 'coba' dalam dokumen yang baru dibuat
    await FirebaseFirestore.instance
        .collection('workouts')
        .doc(workoutDocumentId)
        .collection('exercises');

    Navigator.pop(context); // Menutup dialog
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

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

  void deleteWorkout(int index, AsyncSnapshot<QuerySnapshot> snapshot) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Workout'),
        content: Text('Are you sure you want to delete this workout?'),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          MaterialButton(
            onPressed: () async {
              // Use the actual document ID obtained from the snapshot
              String workoutDocumentId = snapshot.data!.docs[index].id;

              // Delete the workout document from Firestore using the correct document ID
              await FirebaseFirestore.instance
                  .collection('workouts')
                  .doc(workoutDocumentId)
                  .delete();

              // Notify the WorkoutData provider to update the local state
              Provider.of<WorkoutData>(context, listen: false)
                  .deleteWorkout(index);

              Navigator.pop(context); // Close the dialog
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void editWorkout(int index, AsyncSnapshot<QuerySnapshot> snapshot) {
    TextEditingController editController = TextEditingController();

    // Set the initial text in the dialog to the current workout name
    editController.text = snapshot.data!.docs[index]['name'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Workout Name'),
        content: TextField(controller: editController),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          MaterialButton(
            onPressed: () async {
              // Get the new workout name from the TextEditingController
              String newWorkoutName = editController.text;
              // Update the workout name in Firestore
              await FirebaseFirestore.instance
                  .collection('workouts')
                  .doc(snapshot.data!.docs[index].id)
                  .update({'name': newWorkoutName});
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Workout'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('workouts').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            var workouts = snapshot.data!.docs;
            return ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, index) => Slidable(
                endActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      editWorkout(index, snapshot);
                    },
                    backgroundColor: const Color.fromARGB(255, 66, 66, 66),
                    icon: Icons.settings,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      deleteWorkout(index, snapshot);
                    },
                    backgroundColor: Color.fromARGB(255, 240, 39, 39),
                    icon: Icons.delete,
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ]),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: workouts[index]['isCompleted']
                      ? Colors.green
                      : Color.fromRGBO(74, 74, 74, 0.898),
                  child: ListTile(
                    title: Text(
                      workouts[index]['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: workouts[index]['isCompleted'],
                          onChanged: (value) {
                            // Handle checkbox change if needed
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios,
                              color: Colors.white),
                          onPressed: () => goToExercisePage(
                            workouts[index]['name'],
                            workouts[index].id,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
