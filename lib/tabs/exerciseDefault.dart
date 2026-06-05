import 'package:flutter/material.dart';

class myexercise extends StatelessWidget {
  final String workoutDifficulty;
  final List<dynamic> workoutExercises;
  final int selectedExerciseIndex;

  const myexercise({
    required this.workoutDifficulty,
    required this.workoutExercises,
    required this.selectedExerciseIndex,
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
      body: Container(
        color: Color.fromARGB(255, 28, 28, 30),
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  workoutExercises[selectedExerciseIndex]['name'] ??
                      'Selected Workout',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reps',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Sets',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Weight',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Duration',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Display workout details here, e.g., reps, sets, weight, duration
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      workoutExercises[selectedExerciseIndex]['reps']
                          .toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      workoutExercises[selectedExerciseIndex]['sets']
                          .toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      workoutExercises[selectedExerciseIndex]['weight']
                          .toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      workoutExercises[selectedExerciseIndex]['duration'] !=
                              null
                          ? workoutExercises[selectedExerciseIndex]['duration']
                              .toString()
                          : 'None',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      workoutExercises[selectedExerciseIndex]['desc']
                          .toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
