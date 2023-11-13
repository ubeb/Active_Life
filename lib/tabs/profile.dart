import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba/tabs/getUserName.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Logout"),
              onPressed: () {
                // Perform the logout actions here.
                // Navigate to the login page or other desired page.
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => logout(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/image009.jpg'),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Name'),
                subtitle: Text('No Name'),
              ),
              ListTile(
                leading: Icon(Icons.cake),
                title: Text('Age'),
                subtitle: Text('Age not available'),
              ),
              ListTile(
                leading: Icon(Icons.fitness_center),
                title: Text('Weight'),
                subtitle: Text('Weight not available'),
              ),
              ListTile(
                leading: Icon(Icons.height),
                title: Text('Height'),
                subtitle: Text('Height not available'),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/editProfile');
                  },
                  child: Text('Edit Profile'),
                ),
              ),
            ],
          ),
        ));
  }
}
