import 'package:flutter/material.dart';
import 'package:hamro_cinema/models/shows.dart';
import 'package:hamro_cinema/providers/review_provider.dart';
import 'package:hamro_cinema/providers/seat_provider.dart';
import 'package:hamro_cinema/screens/payment_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:hamro_cinema/widgets/general_drop_down.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SeatsScreen extends StatelessWidget {
  SeatsScreen({
    Key? key,
    required this.show,
  }) : super(key: key);

  final Show show;
  final seatController = TextEditingController();
  onChanged(BuildContext context, value) {
    seatController.text = Provider.of<SeatProvider>(context, listen: false)
        .listOfSeats[value]
        .id
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<SeatProvider>(context, listen: false)
        .fetchSeats(theaterId: show.theater.id);
    final reviewFuture = Provider.of<ReviewProvider>(context, listen: false)
        .fetchReviews(show.theater.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Seats"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: show.isHouseFull
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * .75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Houseful!!!",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        "Sorry, No seats available. :(",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Book a Seat",
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Show Time: ${DateFormat("yyyy-MMMM-dd").format(show.date)} ${show.showTime}",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FutureBuilder(
                      future: future,
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final data =
                            Provider.of<SeatProvider>(context, listen: false)
                                .listOfSeats;
                        final list = [];
                        for (var a in data) {
                          list.add(" Row: ${a.row}, No: ${a.number}");
                        }
                        return Column(
                          children: [
                            GeneralDropDown(
                              method: onChanged,
                              list: list,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (seatController.text.isNotEmpty) {
                                  await Provider.of<SeatProvider>(context,
                                          listen: false)
                                      .reserveSeat(
                                    context,
                                    show.id,
                                    int.parse(seatController.text),
                                  );
                                  navigate(
                                    context,
                                    PaymentScreen(
                                      show: show,
                                      seatId: int.parse(seatController.text),
                                    ),
                                  );
                                }
                              },
                              child: const Text("Buy Now"),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FutureBuilder(
                      future: reviewFuture,
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final data =
                            Provider.of<ReviewProvider>(context, listen: false)
                                .reviews;
                        return ListView.builder(
                          itemBuilder: ((context, index) => Card(
                              elevation: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data[index].username} reviewed this theater",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    ListTile(
                                      tileColor: const Color(0xffF8F9FD),
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(data[index].comment),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.star_outlined,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(data[index].ratings.toString())
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                          itemCount: data.length,
                          shrinkWrap: true,
                          primary: false,
                        );
                      }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
