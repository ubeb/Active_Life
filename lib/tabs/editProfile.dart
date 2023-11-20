import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileEditPage extends StatefulWidget {
  final String name;
  final String email;

  ProfileEditPage({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late User user; // Use late keyword to initialize later
  late DocumentReference userData; // Use late keyword to initialize later
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    userData = FirebaseFirestore.instance.collection('users').doc(user.uid);
    nameController.text = widget.name;
    emailController.text = widget.email;
    // Initialize other controllers with current values or leave them empty as needed
  }

  void saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Get the updated values
      final updatedName = nameController.text;
      final updatedEmail = emailController.text;

      try {
        // Update the data in Firestore using the user variable from initState
        await userData.update({
          'name': updatedName,
          'email': updatedEmail,
          // Add other fields as needed
        });

        // Close the edit profile page
        Navigator.of(context).pop();
      } catch (e) {
        // Handle errors, such as Firestore update errors
        print("Error updating profile: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        title: Text(
          'Edit Profile',
          style: TextStyle(
              color: Color.fromARGB(
            255,
            208,
            253,
            62,
          )),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 28, 28, 30),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white), // Set the border color here
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white), // Set the border color here
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white), // Set the border color here
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white), // Set the border color here
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 208, 253, 62),
                        onPrimary: Color.fromARGB(255, 28, 28, 30),
                      ),
                      onPressed: saveProfile,
                      child: Text('Save Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
