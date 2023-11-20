import 'package:coba/firebase_api.dart';
import 'package:coba/models/workout_data.dart';
import 'package:coba/splash.dart';
import 'package:coba/tabs/crud.dart';
import 'package:coba/tabs/editProfile.dart';
import 'package:coba/tabs/fcm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  runApp(
    MyApp(),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  WidgetsFlutterBinding.ensureInitialized();
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
        navigatorKey: navigatorKey,
        routes: {
          '/editProfile': (context) => ProfileEditPage(
                name: '',
                email: '',
              ),
          '/notifpage': (context) => fcm(),
          '/workout': (context) => crud(),
        },
        theme: ThemeData(
          radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.all(
              Color.fromARGB(
                255,
                208,
                253,
                62,
              ),
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Color.fromARGB(
              255,
              208,
              253,
              62,
            ),
            unselectedLabelColor: Colors.white,
          ),
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(
              Color.fromARGB(
                255,
                208,
                253,
                62,
              ),
            ),
            trackColor: MaterialStateProperty.all(
              Colors.grey[400],
            ),
          ),
          // Modify text cursor color
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Color.fromARGB(
              255,
              208,
              253,
              62,
            ), // Change this to your desired text cursor color
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(
                  secondary: Color.fromARGB(
                255,
                208,
                253,
                62,
              ))
              .copyWith(
                  secondary: Color.fromARGB(
                255,
                208,
                253,
                62,
              )),
        ),
        home: Scaffold(
          body: splash(),
        ),
      ),
    );
  }
}
