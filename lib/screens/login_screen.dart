import 'package:flutter/material.dart';
import 'package:hamro_cinema/providers/weather_provider.dart';
import 'package:hamro_cinema/screens/forgot_password_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';
import '/providers/login_provider.dart';
import 'package:provider/provider.dart';

import '/constants/constants.dart';
import '/screens/home_screen.dart';
import '/screens/register_screen.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  // final bool canCheckBioMetric;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: basePadding,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Image.asset(
                //   ImageConstants.logo,
                //   width: SizeConfig.width * 40,
                //   height: SizeConfig.height * 25,
                // ),
                const SizedBox(
                  height: 8,
                ),
                GeneralTextField(
                  title: "Username",
                  controller: usernameController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validate: (value) =>
                      ValidationMixin().validate(value!, "Username"),
                ),
                const SizedBox(
                  height: 16,
                ),
                GeneralTextField(
                  title: "Password",
                  isObscure: true,
                  controller: passwordController,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validate: (value) =>
                      ValidationMixin().validatePassword(value!),
                  onFieldSubmitted: (_) {
                    _submit(context, false);
                  },
                ),
                const SizedBox(
                  height: 2,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => navigate(context, ForgotPasswordScreen()),
                    child: const Text("Forgot Password?"),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _submit(context, false);
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("OR"),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context, bool isAuthenticated) async {
    final dialog = GeneralAlertDialog();

    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      dialog.customLoadingDialog(context);
      await Provider.of<LoginProvider>(context, listen: false).loginUser(
          username: usernameController.text, password: passwordController.text);
      await Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeatherData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } catch (ex) {
      Navigator.pop(context);
      dialog.customAlertDialog(context, ex.toString());
    }
  }
}
