import 'dart:async';
import 'package:coba/login/auth_page.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => authpage(),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      body: Center(
        child: Icon(Icons.fitness_center,
            size: 100.0,
            color: Color.fromARGB(
              255,
              208,
              253,
              62,
            )),
      ),
    );
  }
}
