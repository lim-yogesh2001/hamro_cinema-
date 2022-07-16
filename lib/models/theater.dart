// To parse this JSON data, do
//
//     final theater = theaterFromJson(jsonString);

import 'dart:convert';

import 'package:hamro_cinema/constants/urls.dart';

List<Theater> theaterFromJson(String str) =>
    List<Theater>.from(json.decode(str).map((x) => Theater.fromJson(x)));

String theaterToJson(List<Theater> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
