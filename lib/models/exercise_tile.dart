import 'package:flutter/material.dart';

class ExerciseTile extends StatefulWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  final void Function(bool) onCheckboxChanged;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  ExerciseTile({
    Key? key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckboxChanged,
    required this.onDelete,
    required this.onEdit,
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
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: widget.isCompleted,
              onChanged: (bool? value) {
                // Use null-aware operator to handle null value
                if (value != null) {
                  widget.onCheckboxChanged(value);
                }
              },
            ),
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'edit') {
                  widget.onEdit();
                } else if (result == 'delete') {
                  widget.onDelete();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
