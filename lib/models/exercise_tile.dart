import 'package:flutter/material.dart';

class ExerciseTile extends StatefulWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  final void Function(bool) onCheckboxChanged;

  ExerciseTile({
    Key? key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListTile(
        title: Text(
          widget.exerciseName,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Row(
          children: [
            Chip(
              label: Text(
                "${widget.weight} kg",
              ),
            ),
            Chip(
              label: Text(
                "${widget.reps} reps",
              ),
            ),
            Chip(
              label: Text(
                "${widget.sets} sets",
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.isCompleted,
          onChanged: (bool? value) {
            // Use null-aware operator to handle null value
            if (value != null) {
              widget.onCheckboxChanged(value);
            }
          },
        ),
      ),
    );
  }
}
