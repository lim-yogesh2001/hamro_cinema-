import 'package:flutter/material.dart';
import 'package:hamro_cinema/models/theater.dart';
import 'package:hamro_cinema/screens/theater_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';

class TheaterCard extends StatelessWidget {
  const TheaterCard({
    Key? key,
    required this.theater,
  }) : super(key: key);

  final Theater theater;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextButton(
      // onPressed: () {},
      onPressed: () => navigate(
        context,
        TheaterScreen(
          theater: theater,
        ),
      ),
      child: Column(
        children: [
          Image.network(
            theater.logo,
            height: size.height * .2,
            width: size.width * .45,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            theater.theaterName,
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
