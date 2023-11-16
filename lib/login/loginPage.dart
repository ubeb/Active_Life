import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './signupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true; // Changed variable name for clarity
  bool _pageLogin = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _togglePage(bool switchToLogin) {
    setState(() {
      _pageLogin = switchToLogin;
    });
  }

  void wrongEmail() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Wrong Email"),
          content: Text("Please enter the correct email."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void wrongPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Wrong Password"),
          content: Text("Please enter the correct password."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Simulated login function (replace with your actual authentication logic)
  void _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // Show an error message if any of the fields is empty
      showErrorMessage(context, "Please fill in all the fields.");
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      // Handle specific authentication errors and show user-friendly messages
      if (e.code == 'user-not-found') {
        showErrorMessage(context, "User not found. Please check your email.");
      } else if (e.code == 'wrong-password') {
        showErrorMessage(context, "Incorrect password. Please try again.");
      } else if (e.code == 'invalid-email') {
        showErrorMessage(
            context, "Invalid email address. Please enter a valid email.");
      } else {
        showErrorMessage(context, "An error occurred: ${e.message}");
      }
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 80, bottom: 60),
                child: Center(
                  child: Text(
                    "Active Life",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: _pageLogin ? Colors.white : Colors.black,
                        ),
                      ),
                      onPressed: () {
                        _togglePage(true);
                      },
                    ),
                    ElevatedButton(
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          color: _pageLogin
                              ? Color.fromRGBO(0, 0, 0, 1)
                              : Colors.white,
                        ),
                      ),
                      onPressed: () {
                        _togglePage(false);
                      },
                    ),
                  ],
                ),
              ),
              _pageLogin
                  ? Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: emailController,
                            style: TextStyle(
                                color: Color.fromARGB(255, 128, 128, 128)),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                          TextField(
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
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
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
                    )
                  : SignupPage()
            ],
          ),
        ),
      ),
    );
  }
}
