import 'dart:convert';

List<Ticket> ticketFromJson(String str) =>
    List<Ticket>.from(json.decode(str).map((x) => Ticket.fromJson(x)));

String ticketToJson(List<Ticket> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ticket {
  Ticket({
    required this.id,
    required this.price,
    required this.created,
    required this.modified,
    required this.userId,
    required this.showId,
    required this.seatReservedId,
  });

  final int id;
  final int price;
  final DateTime created;
  final DateTime modified;
  final int userId;
  final int showId;
  final int seatReservedId;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        price: json["Price"],
        created: DateTime.parse(json["created"]),
        modified: DateTime.parse(json["modified"]),
        userId: json["user_id"],
        showId: json["show_id"],
        seatReservedId: json["seat_reserved_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Price": price,
        "created": created.toIso8601String(),
        "modified": modified.toIso8601String(),
        "user_id": userId,
        "show_id": showId,
        "seat_reserved_id": seatReservedId,
      };
}
