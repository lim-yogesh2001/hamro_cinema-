import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hamro_cinema/api/api_call.dart';
import 'package:hamro_cinema/constants/urls.dart';
import 'package:hamro_cinema/models/review.dart';
import 'package:hamro_cinema/providers/login_provider.dart';
import 'package:provider/provider.dart';

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

  postReview(
    BuildContext context, {
    required int id,
    required Map map,
  }) async {
    try {
      final body = {
        "theater_id": id,
        ...map,
        "user_id":
            Provider.of<LoginProvider>(context, listen: false).getUserId(),
      };
      final response =
          await APICall().postRequestWithToken("$theaterReviewUrl/$id/", body);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
}
