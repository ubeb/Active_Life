import 'package:coba/firebase_api.dart';
import 'package:coba/models/workout_data.dart';
import 'package:coba/splash.dart';
import 'package:coba/tabs/editProfile.dart';
import 'package:coba/tabs/fcm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/editProfile': (context) => ProfileEditPage(
                name: 'John Doe',
                age: '28',
                weight: '75',
                height: '180',
              ),
          '/notifpage': (context) => fcm()
        },
        theme: ThemeData(fontFamily: 'Geometria'),
        home: Scaffold(
          body: splash(),
        ),
      ),
    );
  }
}
