import 'dart:developer';

import 'package:flutter/material.dart';
import '/providers/register_provider.dart';
import 'package:provider/provider.dart';
import '/constants/constants.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              GeneralTextField(
                title: "Email",
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validateEmail(value!),
              ),
              const SizedBox(
                height: 16,
              ),
              GeneralTextField(
                title: "Username",
                controller: usernameController,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    ValidationMixin().validate(value!, "Username"),
              ),
              const SizedBox(
                height: 16,
              ),
              GeneralTextField(
                title: "Full Name",
                controller: fullNameController,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    ValidationMixin().validate(value!, "Full Name"),
              ),
              const SizedBox(
                height: 16,
              ),
              GeneralTextField(
                title: "Phone Number",
                controller: phoneController,
                textInputType: TextInputType.phone,
                maxLength: 10,
                textInputAction: TextInputAction.next,
                validate: (value) =>
                    ValidationMixin().validate(value!, "Phone Number"),
              ),
              const SizedBox(
                height: 16,
              ),
              GeneralTextField(
                title: "Password",
                isObscure: true,
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validatePassword(value!),
                onFieldSubmitted: (_) {
                  confirmPasswordFocus.requestFocus();
                },
              ),
              const SizedBox(height: 16),
              GeneralTextField(
                title: "Confirm Password",
                isObscure: true,
                focusNode: confirmPasswordFocus,
                controller: confirmPasswordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validate: (value) => ValidationMixin().validatePassword(
                    passwordController.text,
                    isConfirmPassword: true,
                    confirmValue: value!),
                onFieldSubmitted: (_) {
                  submit(context);
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await submit(context);
                },
                child: const Text("Register"),
              ),
            ],
          ),
        )),
      ),
    );
  }

  submit(context) async {
    log("messagefromAbove");
    final dialog = GeneralAlertDialog();
    log("messageafterdialog");
    try {
      if (_formKey.currentState!.validate()) {
        dialog.customLoadingDialog(context);
        log("message");
        await Provider.of<RegisterProvider>(context, listen: false)
            .registerUser(
          context,
          email: emailController.text,
          username: usernameController.text,
          password: passwordController.text,
          fullName: fullNameController.text,
          phone: phoneController.text,
        );
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (ex) {
      Navigator.pop(context);
      dialog.customAlertDialog(context, ex.toString());
    }
  }
}
