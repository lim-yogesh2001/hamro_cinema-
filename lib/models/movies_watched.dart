// To parse this JSON data, do
//
//     final moviesWatched = moviesWatchedFromJson(jsonString);

import 'dart:convert';

import 'package:hamro_cinema/constants/urls.dart';

List<MoviesWatched> moviesWatchedFromJson(String str) =>
    List<MoviesWatched>.from(
        json.decode(str).map((x) => MoviesWatched.fromJson(x)));

String moviesWatchedToJson(List<MoviesWatched> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoviesWatched {
  MoviesWatched({
    required this.id,
    required this.movieName,
    required this.coverImage,
    required this.genres,
  });

  final int id;
  final String movieName;
  final String coverImage;
  final String genres;

  factory MoviesWatched.fromJson(Map<String, dynamic> json) => MoviesWatched(
        id: json["id"],
        movieName: json["movie_name"],
        coverImage: baseUrl + json["cover_image"],
        genres: json["genres"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "movie_name": movieName,
        "cover_image": coverImage,
        "genres": genres,
      };
}
