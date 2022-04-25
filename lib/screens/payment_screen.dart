import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hamro_cinema/models/shows.dart';
import 'package:hamro_cinema/models/temp_ticket.dart';
import 'package:hamro_cinema/providers/seat_provider.dart';
import 'package:hamro_cinema/providers/ticket_provider.dart';
import 'package:hamro_cinema/screens/home_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:hamro_cinema/widgets/detail_displayer.dart';
import 'package:hamro_cinema/widgets/general_alert_dialog.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key, required this.show, required this.seatId})
      : super(key: key);
  final Show show;
  final int seatId;

  makeConfig(TempTicket tempTicket) {
    return PaymentConfig(
      amount: int.parse(
          "${tempTicket.price.toInt()}00"), // Amount should be in paisa
      productIdentity: tempTicket.id.toString(),
      productName: show.movie.movieName,
      productUrl: 'https://www.khalti.com/#/bazaar',
      additionalData: {
        // Not mandatory; can be used for reporting purpose
        'vendor': 'Hamro Cinema',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tempTicket =
        Provider.of<SeatProvider>(context, listen: false).tempTicket;

    final config = makeConfig(tempTicket!);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pay"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Your Bill Details"),
              const SizedBox(
                height: 16,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailDisplayer(
                        title: "Show Name",
                        value: show.movie.movieName,
                      ),
                      DetailDisplayer(
                        title: "Show Time",
                        value:
                            "Show Time: ${DateFormat("yyyy-MMMM-dd").format(show.date)} ${show.showTime}",
                      ),
                      DetailDisplayer(
                        title: "Theater Name",
                        value: show.theater.theaterName,
                      ),
                      DetailDisplayer(
                        title: "Theater City",
                        value: show.theater.city,
                        isLastElement: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: KhaltiButton(
                  config: config,
                  preferences: const [
                    PaymentPreference.khalti,
                  ],
                  onSuccess: (successModel) async {
                    GeneralAlertDialog().customLoadingDialog(context);
                    await Provider.of<TicketProvider>(context, listen: false)
                        .bookTicket(
                            code: successModel.idx,
                            ticketId: tempTicket.id,
                            seatId: seatId);
                    Navigator.pop(context);
                    await GeneralAlertDialog()
                        .customAlertDialog(context, "Successfully booked");

                    // Perform Server Verification
                    navigateAndRemoveAll(context, const HomeScreen());
                  },
                  onFailure: (failureModel) {
                    // What to do on failure?
                    // log(failureModel.data.toString());
                    GeneralAlertDialog()
                        .customAlertDialog(context, failureModel.message);
                  },
                  onCancel: () {
                    // User manually cancelled the transaction
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
