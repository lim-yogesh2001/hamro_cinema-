// To parse this JSON data, do
//
//     final moviesWatched = moviesWatchedFromJson(jsonString);

import 'package:hamro_cinema/constants/urls.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<MoviesWatched> moviesWatchedFromJson(String str) =>
    List<MoviesWatched>.from(
        json.decode(str).map((x) => MoviesWatched.fromJson(x)));

String moviesWatchedToJson(List<MoviesWatched> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoviesWatched {
  MoviesWatched({
    required this.movieName,
    required this.coverImage,
    required this.showId,
    required this.showTime,
    required this.date,
    required this.theaterName,
    required this.row,
    required this.number,
  });

  final String movieName;
  final String coverImage;
  final String showId;
  final String showTime;
  final DateTime date;
  final String theaterName;
  final int row;
  final int number;

  factory MoviesWatched.fromJson(Map<String, dynamic> json) => MoviesWatched(
        movieName: json["movie_name"],
        coverImage: baseUrl + json["cover_image"],
        showId: json["show_id"],
        showTime: json["show_time"],
        date: DateTime.parse(json["date"]),
        theaterName: json["theater_name"],
        row: json["row"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "movie_name": movieName,
        "cover_image": coverImage,
        "show_id": showId,
        "show_time": showTime,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "theater_name": theaterName,
        "row": row,
        "number": number,
      };
}
