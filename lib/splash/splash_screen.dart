// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:journey_recorded/login/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    func_remember_me();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'SPLASH SCREEN',
        ),
      ),
    );
  }

  // REMEMBER ME
  func_remember_me() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // SharedPreferences preferences =
    // await SharedPreferences.getInstance();
    // await prefs.clear();
    print('=====> SAVED VALUES <=======');
    print(prefs.getInt('userId'));

    if (prefs.getInt('userId').toString() == 'null') {
      print('value is empty');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      print('value is empty 2');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    }
  }
}
