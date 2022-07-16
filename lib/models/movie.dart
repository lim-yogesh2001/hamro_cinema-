import 'dart:convert';

import 'package:hamro_cinema/constants/urls.dart';

List<Movie> movieFromJson(String str) =>
    List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
  Movie({
    required this.id,
    required this.movieName,
    required this.coverImage,
    required this.releaseDate,
    required this.genres,
    required this.director,
    required this.producers,
    required this.casts,
    required this.descripton,
    required this.isUpcoming,
    required this.isPopular,
  });

  final int id;
  final String movieName;
  final String coverImage;
  final DateTime releaseDate;
  final String genres;
  final String director;
  final String producers;
  final String casts;
  final String descripton;
  final bool isUpcoming;
  final bool isPopular;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        movieName: json["movie_name"],
        coverImage: baseUrl + json["cover_image"],
        releaseDate: DateTime.parse(json["release_date"]),
        genres: json["genres"],
        director: json["director"],
        producers: json["producers"],
        casts: json["casts"],
        descripton: json["descripton"],
        isUpcoming: json["is_upcoming"],
        isPopular: json["is_popular"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "movie_name": movieName,
        "cover_image": coverImage,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "genres": genres,
        "director": director,
        "producers": producers,
        "casts": casts,
        "descripton": descripton,
        "is_upcoming": isUpcoming,
        "is_popular": isPopular,
      };
}
