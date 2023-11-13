import 'package:flutter/material.dart';

class Group extends StatelessWidget {
  final String name;
  final List<String> members;

  Group({
    required this.name,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Members: ${members.length}',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 16),
        ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            return Text(
              '${index + 1}. ${members[index]}',
              style: TextStyle(fontSize: 16),
            );
          },
        ),
      ],
    );
  }
}
