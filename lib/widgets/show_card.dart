import 'package:flutter/material.dart';
import 'package:hamro_cinema/models/shows.dart';
import 'package:hamro_cinema/screens/seats_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';

class ShowCard extends StatelessWidget {
  const ShowCard({
    Key? key,
    required this.show,
  }) : super(key: key);

  final Show show;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextButton(
      // onPressed: () {},
      onPressed: () => navigate(
        context,
        SeatsScreen(
          show: show,
        ),
      ),
      child: Column(
        children: [
          Image.network(
            show.theater.logo,
            height: size.height * .2,
            width: size.width * .45,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            show.theater.theaterName,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
