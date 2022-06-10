import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hamro_cinema/models/seats.dart';
import 'package:hamro_cinema/models/ticket.dart';
import 'package:hamro_cinema/utils/request_type.dart';

import '/api/api_call.dart';
import '/constants/urls.dart';

class TicketProvider extends ChangeNotifier {
  List<Ticket> listOfTickets = [];

  fetchTickets() async {
    try {
      final response = await APICall().getRequestWithToken("$ticketUrl");
      listOfTickets = ticketFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  bookTicket({
    required String code,
    required int ticketId,
    required int seatId,
  }) async {
    try {
      final map = {
        "transection_code": code,
        "ticket_id": ticketId,
        "reserved_seat_id": seatId,
      };
      final response = await APICall().postRequestWithToken(
        bookedTicketUrl,
        map,
      );
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
}
