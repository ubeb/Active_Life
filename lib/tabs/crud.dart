import 'package:flutter/material.dart';
import 'package:coba/models/exercise.dart';
import 'package:coba/repositori/repositori.dart';

class crud extends StatefulWidget {
  @override
  _crudState createState() => _crudState();
}

class _crudState extends State<crud> {
  ExerciseRepository repository =
      ExerciseRepository(); // Mengganti ItemRepository menjadi ExerciseRepository
  TextEditingController titleController = TextEditingController();
  bool isErrorVisible = false;

  @override
  Widget build(BuildContext context) {
    isErrorVisible = false;
    return Scaffold(
      body: ListView.builder(
        itemCount:
            repository.exercises.length, // Mengganti items menjadi exercises
        itemBuilder: (context, index) {
          final exercise =
              repository.exercises[index]; // Mengganti item menjadi exercise
          return ListTile(
            title: Text(exercise.Title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String exerciseName = exercise.Title;
                        return AlertDialog(
                          title: Text('Edit Exercise'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                controller: titleController
                                  ..text = exerciseName,
                              ),
                              if (exerciseName.isEmpty && isErrorVisible)
                                Text(
                                  'Nama exercise tidak boleh kosong.',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                exerciseName = titleController.text;
                                if (exerciseName.isNotEmpty) {
                                  repository.updateExercise(
                                      exercise); // Tambahkan metode updateExercise
                                  setState(() {});
                                  titleController.text = '';
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    isErrorVisible = true;
                                  });
                                }
                              },
                              child: Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Konfirmasi Hapus'),
                          content: Text('Anda yakin ingin menghapus item ini?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                repository.deleteExercise(exercise);
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Text('Ya, Hapus'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String exerciseName = '';
              return AlertDialog(
                title: Text('Add Exercise'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                    ),
                    if (exerciseName.isEmpty && isErrorVisible)
                      Text(
                        'Nama exercise tidak boleh kosong.',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      exerciseName = titleController.text;
                      if (exerciseName.isNotEmpty) {
                        repository.addExercise(Exercise(
                            Title: titleController.text,
                            time: '',
                            difficult: '',
                            image: '',
                            description: ''));
                        setState(() {});
                        titleController.text = ''; // Mengosongkan TextField
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          isErrorVisible = true; // Menampilkan pesan kesalahan
                        });
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
