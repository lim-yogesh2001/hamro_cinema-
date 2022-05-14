import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hamro_cinema/models/theater.dart';
import 'package:hamro_cinema/providers/review_provider.dart';
import 'package:hamro_cinema/utils/validation_mixin.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:hamro_cinema/widgets/detail_displayer.dart';
import 'package:hamro_cinema/widgets/general_alert_dialog.dart';
import 'package:hamro_cinema/widgets/general_text_field.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TheaterScreen extends StatelessWidget {
  const TheaterScreen({Key? key, required this.theater}) : super(key: key);

  final Theater theater;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final reviewFuture = Provider.of<ReviewProvider>(context, listen: false)
        .fetchReviews(theater.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(theater.theaterName),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                final map = await showSheet(context);
                if (map != null) {
                  print(map);
                  GeneralAlertDialog().customLoadingDialog(context);
                  Provider.of<ReviewProvider>(context, listen: false)
                      .postReview(
                    context,
                    id: theater.id,
                    map: map,
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              } catch (ex) {
                Navigator.pop(context);
                GeneralAlertDialog().customAlertDialog(context, ex.toString());
              }
            },
            child: const Text(
              "Rate",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: CurvedBodyWidget(
          widget: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              theater.logo,
              width: size.width,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 16,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    DetailDisplayer(
                      title: "Country",
                      value: theater.country.toString(),
                    ),
                    DetailDisplayer(
                      title: "City",
                      value: theater.city.toString(),
                    ),
                    DetailDisplayer(
                      title: "Street",
                      value: theater.street.toString(),
                    ),
                    DetailDisplayer(
                      title: "Total Seats",
                      value: theater.totalSeats.toString(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.contact_phone_outlined,
                ),
                title: Text(theater.contact),
                trailing: const Icon(
                  Icons.call_outlined,
                ),
                onTap: () async {
                  if (await canLaunchUrl(
                      Uri.parse("tel://${theater.contact}"))) {
                    launchUrl(Uri.parse("tel://${theater.contact}"));
                  }
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                bottom: 8,
              ),
              child: Text(
                "Reviews",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            FutureBuilder(
              future: reviewFuture,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data =
                    Provider.of<ReviewProvider>(context, listen: false).reviews;
                return ListView.builder(
                  itemBuilder: ((context, index) => Card(
                          child: ListTile(
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
                      ))),
                  itemCount: data.length,
                  shrinkWrap: true,
                  primary: false,
                );
              }),
            ),
          ],
        ),
      )),
    );
  }

  showSheet(BuildContext context) async {
    double rating = 0;
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return await showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StatefulBuilder(builder: (context, set) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Please give a rating"),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color(0xFFD84315),
                      ),
                      onRatingUpdate: (r) {
                        set(() {
                          rating = r;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GeneralTextField(
                      title: "Comment",
                      controller: controller,
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      maxLines: 3,
                      validate: (v) =>
                          ValidationMixin().validate(v!, "Comment"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(context, {
                            "ratings": rating,
                            "comment": controller.text,
                          });
                        }
                      },
                      child: const Text("Rate"),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
