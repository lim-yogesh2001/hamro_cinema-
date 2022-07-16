import 'dart:convert';

import 'package:hamro_cinema/constants/urls.dart';

List<Show> showFromJson(String str) =>
    List<Show>.from(json.decode(str).map((x) => Show.fromJson(x)));

String showToJson(List<Show> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Show {
  Show({
    required this.id,
    required this.showTime,
    required this.date,
    required this.langauge,
    required this.theater,
    required this.movie,
    required this.isHouseFull,
  });

  final int id;
  final String showTime;
  final DateTime date;
  final String langauge;
  final Theater theater;
  final Movie movie;
  final bool isHouseFull;

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        showTime: json["show_time"],
        date: DateTime.parse(json["date"]),
        langauge: json["langauge"],
        theater: Theater.fromJson(json["theater_id"]),
        movie: Movie.fromJson(json["movie_id"]),
        isHouseFull: json["isHouseFull"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "show_time": showTime,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "langauge": langauge,
        "theater_id": theater.toJson(),
        "movie_id": movie.toJson(),
        "isHouseFull": isHouseFull,
      };
}

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
    required this.isRecommended,
    required this.userId,
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
  final bool isRecommended;
  final List<int> userId;

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
        isRecommended: json["is_recommended"],
        userId: List<int>.from(json["user_id"].map((x) => x)),
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
        "is_recommended": isRecommended,
        "user_id": List<dynamic>.from(userId.map((x) => x)),
      };
}

class Theater {
  Theater({
    required this.id,
    required this.theaterName,
    required this.logo,
    required this.contact,
    required this.country,
    required this.city,
    required this.street,
    required this.totalSeats,
  });

  final int id;
  final String theaterName;
  final String logo;
  final String contact;
  final String country;
  final String city;
  final String street;
  final int totalSeats;

  factory Theater.fromJson(Map<String, dynamic> json) => Theater(
        id: json["id"],
        theaterName: json["theater_name"],
        logo: baseUrl + json["logo"],
        contact: json["contact"],
        country: json["country"],
        city: json["city"],
        street: json["street"],
        totalSeats: json["total_seats"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "theater_name": theaterName,
        "logo": logo,
        "contact": contact,
        "country": country,
        "city": city,
        "street": street,
        "total_seats": totalSeats,
      };
}
