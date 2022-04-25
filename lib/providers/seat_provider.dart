import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hamro_cinema/models/seats.dart';
import 'package:hamro_cinema/models/temp_ticket.dart';
import 'package:hamro_cinema/providers/login_provider.dart';
import 'package:provider/provider.dart';

import '/api/api_call.dart';
import '/constants/urls.dart';

class SeatProvider extends ChangeNotifier {
  List<Seat> listOfSeats = [];
  TempTicket? tempTicket;

  fetchSeats({required int theaterId}) async {
    try {
      if (listOfSeats.isNotEmpty) return;
      final response =
          await APICall().getRequestWithToken("$theaterSeatsUrl/$theaterId");
      listOfSeats = seatFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  Seat getShowById(int id) {
    return listOfSeats.firstWhere((element) => element.id == id);
  }

  reserveSeat(BuildContext context, int showId, int seatId) async {
    try {
      int id = Provider.of<LoginProvider>(context, listen: false).getUserId();
      final map = {
        "reserved": true,
        "user_id": id,
        "seat_id": seatId,
        "show_id": showId
      };
      final response =
          await APICall().postRequestWithToken(reservedSeatsUrl, map);
      tempTicket = tempTicketFromJson(response);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }
}
