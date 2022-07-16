import 'package:flutter/material.dart';
import 'package:hamro_cinema/providers/theater_provider.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:hamro_cinema/widgets/show_card.dart';
import 'package:hamro_cinema/widgets/theater_card.dart';
import 'package:provider/provider.dart';

class ListOfTheaterScreen extends StatelessWidget {
  const ListOfTheaterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future =
        Provider.of<TheaterProvider>(context, listen: false).fetchTheaters();
    return Scaffold(
        appBar: AppBar(
          title: const Text("List of Theaters"),
        ),
        body: CurvedBodyWidget(
          widget: SingleChildScrollView(
            child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final list =
                    Provider.of<TheaterProvider>(context, listen: false)
                        .listOfTheaters;

                return list.isEmpty
                    ? const Center(
                        child: Text("No Theaters Found"),
                      )
                    : GridView.builder(
                        itemCount: list.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) => TheaterCard(
                          theater: list[index],
                        ),
                        shrinkWrap: true,
                        primary: false,
                      );
              },
            ),
          ),
        ));
  }
}
