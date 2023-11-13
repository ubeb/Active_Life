import 'package:coba/splash.dart';
import 'package:coba/tabs/editProfile.dart';
// ignore: unused_import
import 'package:coba/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/editProfile': (context) => ProfileEditPage(
              name: 'John Doe',
              age: '28',
              weight: '75',
              height: '180',
            ),
      },
      theme: ThemeData(fontFamily: 'Geometria'),
      home: Scaffold(
        body: splash(),
      ),
    );
  }
}
