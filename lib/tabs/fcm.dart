import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class fcm extends StatefulWidget {
  const fcm({super.key});

  @override
  State<fcm> createState() => _fcmState();
}

class _fcmState extends State<fcm> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: Text('notif page'),
      ),
      body: Column(
        children: [
          Text(message.notification!.title.toString()),
          Text(message.notification!.body.toString()),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
