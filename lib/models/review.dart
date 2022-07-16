import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    required this.id,
    required this.ratings,
    required this.comment,
    required this.username,
  });

  final int id;
  final int ratings;
  final String comment;
  final String username;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        ratings: json["ratings"],
        comment: json["comment"],
        username: json["user_id"]["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ratings": ratings,
        "comment": comment,
        "username": username,
      };
}
