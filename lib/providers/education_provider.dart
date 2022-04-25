import 'package:flutter/cupertino.dart';
import 'package:hamro_cinema/models/theater.dart';

import '/api/api_call.dart';
import '/constants/urls.dart';

class TheaterProvider extends ChangeNotifier {
  List<Theater> listOfTheaters = [];

  fetchEducation() async {
    try {
      final response = await APICall().getRequestWithToken(theaterListUrl);
      listOfTheaters = theaterFromJson(response);
    } catch (ex) {
      rethrow;
    }
  }
}
