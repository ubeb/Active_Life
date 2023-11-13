import 'package:coba/login/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(
      () {
        _isHidden = !_isHidden;
      },
    );
  }

  Future signUp(BuildContext context) async {
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DataPage(
            name: nameController.text,
            email: emailController.text,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Handle email already in use error
        showErrorMessage(
            "Email is already in use. Please use a different email.");
      } else if (e.code == 'invalid-email') {
        // Handle invalid email error
        showErrorMessage("Invalid email address. Please enter a valid email.");
      } else {
        // Handle other errors
        showErrorMessage("An error occurred: ${e.message}");
      }
    }
  }

  //add user detail
  Future addUserDeatail(String firstName, String email) async {
    await FirebaseFirestore.instance.collection("users").add({
      'name': firstName,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      print("Passwords do not match.");
      return false;
    }
  }

  void showErrorMessage(String message) {
    // You can use this method to display error messages to the user
    print(message);
    // Optionally, show a snackbar or a dialog with the error message
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: nameController,
                          style: TextStyle(
                              color: Color.fromARGB(255, 128, 128, 128)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "First Name",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Color.fromARGB(255, 128, 128, 128)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email address",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        Container(
                          child: TextField(
                            controller: passwordController,
                            obscureText: _isHidden,
                            style: TextStyle(
                                color: Color.fromARGB(255, 128, 128, 128)),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(_isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: _toggleVisibility,
                              ),
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: _isHidden,
                            style: TextStyle(
                                color: Color.fromARGB(255, 128, 128, 128)),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(_isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: _toggleVisibility,
                              ),
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                signUp(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
