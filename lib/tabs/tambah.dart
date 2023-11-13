import 'package:flutter/material.dart';
import 'package:coba/models/exercise.dart';

void main() => runApp(WorkoutBuddy());

class WorkoutBuddy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Workout Buddy');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Exercise> exercises = [];

  void _addExercise(Exercise exercise) {
    setState(() {
      exercises.add(exercise);
    });
  }

  void _editExercise(int index, Exercise exercise) {
    setState(() {
      exercises[index] = exercise;
    });
  }

  void _deleteExercise(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("delete item"),
          content: Text("Are you sure you want to detele?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("delete"),
              onPressed: () {
                // Perform the deletion action
                Navigator.of(context).pop(); // Close the dialog
                _delete(index);
              },
            ),
          ],
        );
      },
    );
  }

  void _delete(int index) {
    // Perform the actual deletion of the exercise
    setState(() {
      exercises.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          // Create workout button
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateWorkout(_addExercise)),
                );
              },
              child: Text('Create Workout'),
            ),
          ),

          // Workout List
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: exercises.asMap().entries.map((entry) {
                int index = entry.key;
                Exercise exercise = entry.value;
                return Card(
                  child: ListTile(
                    title: Text(exercise.Title),
                    subtitle: Text(exercise.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.0),
                            Text('Duration: ${exercise.time}'),
                            SizedBox(height: 5.0),
                            Text('level: ${exercise.difficult}'),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditExercise(
                                      exercise, index, _editExercise)),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteExercise(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateWorkout(_addExercise)),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreateWorkout extends StatefulWidget {
  final Function(Exercise) addExercise;

  CreateWorkout(this.addExercise);

  @override
  _CreateWorkoutState createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  TextEditingController _exerciseNameController = TextEditingController();
  TextEditingController _exerciseDescriptionController =
      TextEditingController();
  TextEditingController _exerciseDifficultController = TextEditingController();
  TextEditingController _exerciseDurationController = TextEditingController();

  void _createExercise() {
    if (_exerciseNameController.text.isNotEmpty &&
        _exerciseDescriptionController.text.isNotEmpty &&
        _exerciseDifficultController.text.isNotEmpty &&
        _exerciseDurationController.text.isNotEmpty) {
      Exercise exercise = Exercise(
          Title: _exerciseNameController.text,
          difficult: _exerciseDifficultController.text,
          time: _exerciseDurationController.text + ' ' + _selectedDurationUnit,
          description: _exerciseDescriptionController.text,
          image: '');
      widget.addExercise(exercise);
      Navigator.pop(context);
    }
  }

  String _selectedDurationUnit = 'min';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _exerciseNameController,
              decoration: InputDecoration(
                labelText: 'Exercise Name',
              ),
            ),
            TextField(
              controller: _exerciseDurationController,
              decoration: InputDecoration(
                labelText: 'Exercise duration',
              ),
            ),
            DropdownButton<String>(
              value: _selectedDurationUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDurationUnit = newValue!;
                });
              },
              items: <String>['min', 'sec', 'rep']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _exerciseDifficultController,
              decoration: InputDecoration(
                labelText: 'Exercise level',
              ),
            ),
            TextField(
              controller: _exerciseDescriptionController,
              decoration: InputDecoration(
                labelText: 'Exercise Description',
              ),
            ),
            ElevatedButton(
              onPressed: _createExercise,
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditExercise extends StatefulWidget {
  final Exercise exercise;
  final int index;
  final Function(int, Exercise) editExercise;

  EditExercise(this.exercise, this.index, this.editExercise);

  @override
  _EditExerciseState createState() => _EditExerciseState();
}

class _EditExerciseState extends State<EditExercise> {
  late TextEditingController _exerciseNameController;
  late TextEditingController _exerciseDescriptionController;
  late TextEditingController _exerciseDifficultController;
  late TextEditingController _exerciseDurationController;

  @override
  void initState() {
    super.initState();
    _exerciseNameController =
        TextEditingController(text: widget.exercise.Title);
    _exerciseDescriptionController =
        TextEditingController(text: widget.exercise.description);
    _exerciseDifficultController =
        TextEditingController(text: widget.exercise.difficult);
    _exerciseDurationController =
        TextEditingController(text: widget.exercise.time);
  }

  String extractDurationValue(String duration) {
    List<String> parts = duration.split(' ');
    if (parts.length == 2) {
      return parts[0];
    } else {
      return '';
    }
  }

  void _updateExercise() {
    if (_exerciseNameController.text.isNotEmpty &&
        _exerciseDescriptionController.text.isNotEmpty) {
      Exercise updatedExercise = Exercise(
          Title: _exerciseNameController.text,
          difficult: _exerciseDifficultController.text,
          time: _exerciseDurationController.text + ' ' + _selectedDurationUnit,
          description: _exerciseDescriptionController.text,
          image: '');
      widget.editExercise(widget.index, updatedExercise);
      Navigator.pop(context);
    }
  }

  String _selectedDurationUnit = 'min';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _exerciseNameController,
              decoration: InputDecoration(
                labelText: 'Exercise Name',
              ),
            ),
            TextField(
              controller: _exerciseDurationController,
              decoration: InputDecoration(
                labelText: 'Exercise duration',
              ),
            ),
            DropdownButton<String>(
              value: _selectedDurationUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDurationUnit = newValue!;
                });
              },
              items: <String>['min', 'sec', 'rep']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _exerciseDifficultController,
              decoration: InputDecoration(
                labelText: 'Exercise level',
              ),
            ),
            TextField(
              controller: _exerciseDescriptionController,
              decoration: InputDecoration(
                labelText: 'Exercise Description',
              ),
            ),
            ElevatedButton(
              onPressed: _updateExercise,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
