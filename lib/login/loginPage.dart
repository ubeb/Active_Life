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
  TextEditingController usernameController = TextEditingController();
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
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        wrongEmail();
      } else if (e.code == 'wrong-password') {
        wrongPassword();
      }
    }
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
                      color: Color.fromRGBO(143, 148, 251, 1),
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
                            controller: usernameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: _isHidden,
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
