import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class fcm extends StatefulWidget {
  const fcm({Key? key});

  @override
  State<fcm> createState() => _fcmState();
}

class _fcmState extends State<fcm> {
  @override
  Widget build(BuildContext context) {
    // Get the arguments from the route settings
    final arguments = ModalRoute.of(context)?.settings.arguments;

    // Check if arguments is not null and is of type RemoteMessage
    if (arguments is RemoteMessage) {
      final message = arguments;

      return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: Column(
          children: [
            Text(message.notification?.title.toString() ?? ''),
            Text(message.notification?.body.toString() ?? ''),
            Text(message.data.toString()),
          ],
        ),
      );
    } else {
      // Handle the case where arguments is null or not of type RemoteMessage
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Invalid message format'),
        ),
      );
    }
  }
}
