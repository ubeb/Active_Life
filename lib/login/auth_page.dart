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
          if (snapshot.data != null && snapshot.data!.uid.isNotEmpty) {
            // User is authenticated
            return Tabs(
              userData: {}, // You might want to fetch user data here
            );
          } else {
            // User is not authenticated
            return LoginPage();
          }
        },
      ),
    );
  }
}
