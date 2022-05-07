import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hamro_cinema/constants/constants.dart';
import 'package:hamro_cinema/screens/login_screen.dart';
import 'package:hamro_cinema/screens/register_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF9F3),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () => navigateAndRemoveAll(context, LoginScreen()),
                child: const Text("Login"),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Colors.blue,
                  ),
                ),
                onPressed: () => navigate(context, RegisterScreen()),
                child: const Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
