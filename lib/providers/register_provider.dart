import 'dart:developer';

import 'package:flutter/material.dart';
import '/api/api_call.dart';
import '/constants/urls.dart';

class RegisterProvider extends ChangeNotifier {
  registerUser(
    BuildContext context, {
    required String email,
    required String username,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      final map = {
        "email": email,
        "username": username,
        "password": password,
        "full_name": fullName,
        "phone": phone,
      };
      log(map.toString());
      await APICall().postRequestWithoutToken(registerUrl, map);
    } catch (ex) {
      rethrow;
    }
  }
}
