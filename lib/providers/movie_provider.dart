import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hamro_cinema/providers/login_provider.dart';
import 'package:provider/provider.dart';

import '/api/api_call.dart';
import '/constants/urls.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> listOfMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> recommendedMovies = [];

  resetMovies() {
    listOfMovies.clear();
    upcomingMovies.clear();
    recommendedMovies.clear();
  }

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
      if (upcomingMovies.isNotEmpty) return;
      final response = await APICall().getRequestWithToken(upcomingMoviesUrl);

      upcomingMovies = movieFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  fetchRecommendedMovies(BuildContext context) async {
    try {
      if (recommendedMovies.isNotEmpty) return;
      final id =
          Provider.of<LoginProvider>(context, listen: false).user!.user.id;
      final response =
          await APICall().getRequestWithToken("$recommendedMoviesUrl/$id");
      recommendedMovies = movieFromJson(response);
      log(response.toString());
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
    final list = [...listOfMovies, ...upcomingMovies, ...recommendedMovies];
    return list.firstWhere((element) => element.id == id);
  }
}
