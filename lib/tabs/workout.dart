import 'package:flutter/material.dart';

class workout extends StatefulWidget {
  final List<Map<String, dynamic>> workouts;

  const workout({Key? key, required this.workouts}) : super(key: key);

  @override
  State<workout> createState() => _workoutState();
}

class _workoutState extends State<workout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('workout'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [Text("Workout Plans"), Text('tes')],
          ),
        ));
  }
}
