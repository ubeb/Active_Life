import 'package:coba/login/loginPage.dart';
import 'package:coba/tabs/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authpage extends StatefulWidget {
  const authpage({Key? key}) : super(key: key);

  @override
  _authpageState createState() => _authpageState();
}

class _authpageState extends State<authpage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print("User UID: ${user?.uid}");

    if (user != null && user.uid.isNotEmpty) {
      return Tabs(
        userData: {},
      );
    } else {
      return LoginPage();
    }
  }
}
