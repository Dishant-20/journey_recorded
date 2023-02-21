import 'package:flutter/material.dart';
import 'package:journey_recorded/dashboard/dashboard.dart';
import 'package:journey_recorded/login/login.dart';
import 'package:journey_recorded/registration/registration.dart';
import 'package:journey_recorded/splash/splash_screen.dart';
// import 'package:triple_r_custom/classes/continue_as_a/continue_as_a.dart';

void main() async {
  //
  //
  /*WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final token = await _firebaseMessaging.getToken();
  //
  //
  print(token);

  FirebaseMessaging.onMessage.listen(
    (event) {
      print("event ${event.notification!.body}");
    },
  );*/

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}
