// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.fullName,
    required this.dateJoined,
  });

  final int id;
  final String username;
  final String email;
  late String phone;
  late String fullName;
  final DateTime dateJoined;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        fullName: json["full_name"],
        dateJoined: DateTime.parse(json["date_joined"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone": phone,
        "full_name": fullName,
        "date_joined": dateJoined.toIso8601String(),
      };
}
