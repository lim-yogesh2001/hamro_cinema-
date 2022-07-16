import 'package:flutter/material.dart';
import 'package:hamro_cinema/providers/login_provider.dart';
import 'package:hamro_cinema/screens/confirm_forgot_password_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';
import 'package:hamro_cinema/utils/validation_mixin.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:hamro_cinema/widgets/general_alert_dialog.dart';
import 'package:hamro_cinema/widgets/general_text_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CurvedBodyWidget(
          widget: Column(
            children: [
              Text(
                "Forgot your password?",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "No worry, we got you covered!!!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Enter your email associated with the account",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: formKey,
                child: GeneralTextField(
                  title: "Email",
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validate: (value) => ValidationMixin().validateEmail(value!),
                  onFieldSubmitted: (_) {
                    Provider.of<LoginProvider>(context, listen: false)
                        .forgotPassword(context, email: emailController.text);
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await Provider.of<LoginProvider>(context, listen: false)
                        .forgotPassword(context, email: emailController.text);
                  }
                },
                child: const Text("Send Token"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
