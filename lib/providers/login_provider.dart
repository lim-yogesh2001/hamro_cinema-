import 'package:flutter/material.dart';
import 'package:hamro_cinema/models/profile.dart';
import 'package:hamro_cinema/models/user.dart';
import 'package:hamro_cinema/screens/login_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';
import 'package:hamro_cinema/utils/request_type.dart';
import 'package:hamro_cinema/widgets/general_alert_dialog.dart';
import '/api/api_call.dart';
import '/api/api_client.dart';
import '/constants/urls.dart';

class LoginProvider extends ChangeNotifier {
  User? user;
  Profile? profile;
  loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final map = {"username": username, "password": password};

      user =
          userFromJson(await APICall().postRequestWithoutToken(loginUrl, map));
      APIClient.token = user!.token;
      profile = profileFromJson(
          await APICall().getRequestWithToken("$profileUrl${user!.user.id}"));

      notifyListeners();
    } catch (ex) {
      rethrow;
    }
  }

  int getUserId() {
    return user!.user.id;
  }

  logout(BuildContext context) async {
    try {
      GeneralAlertDialog().customLoadingDialog(context);
      await APICall().postRequestWithToken(logoutUrl, {});
      Navigator.pop(context);
      APIClient.token = "";
      user = null;
      navigateAndRemoveAll(context, LoginScreen());
    } catch (ex) {
      rethrow;
    }
  }

  changePassword(
    BuildContext context, {
    required Map map,
  }) async {
    try {
      GeneralAlertDialog().customLoadingDialog(context);
      await APICall().postRequestWithToken(
        changePasswordUrl,
        map,
        requestType: RequestType.putWithToken,
      );
      Navigator.pop(context);
      APIClient.token = "";
      user = null;
      navigateAndRemoveAll(context, LoginScreen());
    } catch (ex) {
      rethrow;
    }
  }

  updateProfile(
    BuildContext context, {
    required Map map,
  }) async {
    try {
      GeneralAlertDialog().customLoadingDialog(context);
      final body = {
        ...map,
        "username": profile!.username,
      };
      await APICall().postRequestWithToken(
        "$profileUrl${user!.user.id}/",
        body,
        requestType: RequestType.putWithToken,
      );
      Navigator.pop(context);
      profile!.fullName = map["full_name"];
      profile!.phone = map["phone_number"];
      notifyListeners();
    } catch (ex) {
      rethrow;
    }
  }
}
