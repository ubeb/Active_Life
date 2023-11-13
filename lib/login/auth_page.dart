import 'package:coba/login/loginPage.dart';
import 'package:coba/tabs/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authpage extends StatefulWidget {
  const authpage({super.key});

  @override
  State<authpage> createState() => _authpageState();
}

class _authpageState extends State<authpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Tabs(
              userData: {},
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
