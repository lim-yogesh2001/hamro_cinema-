import 'dart:developer';

import 'package:flutter/material.dart';

import '/api/api_call.dart';
import '/constants/urls.dart';
import '/models/movies_watched.dart';

class MoviesWatchedProvider extends ChangeNotifier {
  List<MoviesWatched> moviesWatched = [];

  fetchWatchedMovies(int userId) async {
    try {
      final response =
          await APICall().getRequestWithToken("$watchedMoviesUrl$userId");
      moviesWatched = moviesWatchedFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
}
