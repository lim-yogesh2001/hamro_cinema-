import 'package:flutter/material.dart';
import 'package:hamro_cinema/screens/get_started_screen.dart';
import 'package:hamro_cinema/screens/login_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        navigateAndRemoveAll(context, const GetStartedScreen());
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xffFFF9F3),
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
