import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hamro_cinema/api/api_call.dart';
import 'package:hamro_cinema/constants/urls.dart';
import 'package:hamro_cinema/models/review.dart';

class ReviewProvider extends ChangeNotifier {
  List<Review> reviews = [];

  fetchReviews(int id) async {
    try {
      final response =
          await APICall().getRequestWithToken("$theaterReviewUrl/$id");
      reviews = reviewFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
}
