import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '/api/api_call.dart';
import '/constants/urls.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> listOfMovies = [];
  List<Movie> upcomingMovies = [];

  fetchMovies() async {
    try {
      if (listOfMovies.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(movieListUrl);
      listOfMovies = movieFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  fetchUpcomingMovies() async {
    try {
      if (listOfMovies.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(upcomingMoviesUrl);
      upcomingMovies = movieFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  // updateQuantity(int id, int quantity) {
  //   getProductById(id).selectedQuantity = quantity;
  //   notifyListeners();
  // }

  Movie getMovieById(int id) {
    final list = [...listOfMovies, ...upcomingMovies];
    return list.firstWhere((element) => element.id == id);
  }
}
