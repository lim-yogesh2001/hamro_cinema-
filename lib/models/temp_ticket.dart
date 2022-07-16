import 'dart:convert';

TempTicket tempTicketFromJson(String str) =>
    TempTicket.fromJson(json.decode(str));

String tempTicketToJson(TempTicket data) => json.encode(data.toJson());

class TempTicket {
  TempTicket({
    required this.id,
    required this.price,
  });

  final int id;
  final int price;

  factory TempTicket.fromJson(Map<String, dynamic> json) => TempTicket(
        id: json["id"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
      };
}
