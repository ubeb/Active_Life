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
  final user = FirebaseAuth.instance.currentUser!;
  final userData = FirebaseFirestore.instance.collection('users').doc();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    // Initialize other controllers with current values or leave them empty as needed
  }

  void saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Get the updated values
      final updatedName = nameController.text;
      final updatedEmail = emailController.text;

      // Update the data in Firestore
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid); // Get the DocumentReference, not DocumentSnapshot
      await userDoc.update({
        'name': updatedName,
        'email': updatedEmail,
        // Add other fields as needed
      });

      // Close the edit profile page
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: saveProfile,
                  child: Text('Save Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
