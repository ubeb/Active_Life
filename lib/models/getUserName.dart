import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetuserName extends StatelessWidget {
  final String documentId;

  const GetuserName({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Name: ${data['name']}'),
              // Text('Age: ${data['age']}'),
              // Text('Weight: ${data['weight']}'),
              // Text('Height: ${data['height']}'),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Name'),
                subtitle: Text('${data['name']}'),
              ),
              ListTile(
                leading: Icon(Icons.cake),
                title: Text('Age'),
                subtitle: Text('${data['age']}'),
              ),
              ListTile(
                leading: Icon(Icons.fitness_center),
                title: Text('Weight'),
                subtitle: Text('${data['weight']}'),
              ),
              ListTile(
                leading: Icon(Icons.height),
                title: Text('Height'),
                subtitle: Text('${data['height']}'),
              ),
              Text('Email: ${data['email']}'),
              Text('uid: ${data['uid']}'),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/editProfile');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 45, 45, 45),
                  ),
                  child: Text('Edit Profile'),
                ),
              ),
            ],
          );
        }
        return Text("loading...");
      }),
    );
  }
}
