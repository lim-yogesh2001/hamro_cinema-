import 'package:flutter/material.dart';
import 'package:hamro_cinema/providers/show_provider.dart';
import 'package:hamro_cinema/widgets/show_card.dart';
import 'package:provider/provider.dart';

import '/widgets/curved_body_widget.dart';

class ShowsScreen extends StatelessWidget {
  const ShowsScreen({Key? key, required this.movieId}) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<ShowProvider>(context, listen: false)
        .fetchShows(movieId: movieId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shows"),
      ),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder(
                future: future,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<ShowProvider>(
                    builder: (context, value, child) => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (_, index) {
                        return ShowCard(
                          show: value.listOfShows[index],
                        );
                      },
                      itemCount: value.listOfShows.length,
                      shrinkWrap: true,
                    ),
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
