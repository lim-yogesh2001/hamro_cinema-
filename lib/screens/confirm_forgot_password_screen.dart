import 'package:flutter/material.dart';
import 'package:hamro_cinema/providers/login_provider.dart';
import 'package:hamro_cinema/screens/login_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';
import 'package:hamro_cinema/utils/validation_mixin.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:hamro_cinema/widgets/general_text_field.dart';
import 'package:provider/provider.dart';

class ConfirmForgotPasswordScreen extends StatelessWidget {
  ConfirmForgotPasswordScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final tokenController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CurvedBodyWidget(
          widget: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Password Recovery",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Enter the token and new password",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 16,
                ),
                GeneralTextField(
                  title: "Token",
                  controller: tokenController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validate: (value) =>
                      ValidationMixin().validate(value!, "Token"),
                  onFieldSubmitted: (_) {},
                ),
                const SizedBox(
                  height: 16,
                ),
                GeneralTextField(
                  title: "New Password",
                  controller: passwordController,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validate: (value) => ValidationMixin().validatePassword(
                    value!,
                  ),
                  onFieldSubmitted: (_) {},
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await Provider.of<LoginProvider>(context, listen: false)
                          .confirmForgotPassword(context,
                              token: tokenController.text.trim(),
                              password: passwordController.text);
                      navigateAndRemoveAll(context, LoginScreen());
                    }
                  },
                  child: const Text("Recover Account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
