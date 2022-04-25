import 'package:flutter/material.dart';
import 'package:hamro_cinema/providers/login_provider.dart';
import 'package:hamro_cinema/screens/payment_screen.dart';
import 'package:hamro_cinema/utils/validation_mixin.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:hamro_cinema/widgets/detail_displayer.dart';
import 'package:hamro_cinema/widgets/general_text_field.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginProvider>(context, listen: false).user!.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your profile"),
      ),
      body: CurvedBodyWidget(
          widget: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DetailDisplayer(
                      title: "Username",
                      value: user.username,
                    ),
                    DetailDisplayer(
                      title: "Email",
                      value: user.email,
                      isLastElement: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                final map = await customBottomSheet(context);
                if (map != null) {
                  await Provider.of<LoginProvider>(context, listen: false)
                      .changePassword(context, map: map);
                }
              },
              child: const Text("Change Password"),
            ),
          ],
        ),
      )),
    );
  }
}

customBottomSheet(BuildContext context) async {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  return await showModalBottomSheet(
    context: context,
    builder: (_) => Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        24,
        16,
        MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GeneralTextField(
                title: "Old Password",
                isObscure: true,
                controller: oldPassword,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validatePassword(value!),
              ),
              const SizedBox(
                height: 16,
              ),
              GeneralTextField(
                title: "New Password",
                isObscure: true,
                controller: newPassword,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validatePassword(value!),
              ),
              const SizedBox(
                height: 16,
              ),
              GeneralTextField(
                title: "Confirm Password",
                isObscure: true,
                controller: confirmPassword,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validate: (value) => ValidationMixin().validatePassword(
                  value!,
                  isConfirmPassword: true,
                  confirmValue: newPassword.text,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final map = {
                      "old_password": oldPassword.text,
                      "new_password": newPassword.text
                    };
                    Navigator.pop(context, map);
                  }
                },
                child: const Text("Change"),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
