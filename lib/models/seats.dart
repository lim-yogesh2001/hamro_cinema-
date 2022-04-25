import 'dart:convert';

List<Seat> seatFromJson(String str) =>
    List<Seat>.from(json.decode(str).map((x) => Seat.fromJson(x)));

String seatToJson(List<Seat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Seat {
  Seat({
    required this.id,
    required this.row,
    required this.number,
    required this.theaterId,
  });

  final int id;
  final int row;
  final int number;
  final int theaterId;

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        id: json["id"],
        row: json["row"],
        number: json["number"],
        theaterId: json["theater_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "row": row,
        "number": number,
        "theater_id": theaterId,
      };
}
