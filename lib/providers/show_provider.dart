import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '/api/api_call.dart';
import '/constants/urls.dart';
import '/models/shows.dart';

class ShowProvider extends ChangeNotifier {
  List<Show> listOfShows = [];

  fetchShows({required int movieId}) async {
    try {
      if (listOfShows.isNotEmpty) return;
      final response =
          await APICall().getRequestWithToken("$showsListUrl/$movieId");
      listOfShows = showFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  Show getShowById(int id) {
    return listOfShows.firstWhere((element) => element.id == id);
  }
}
