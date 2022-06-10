import 'package:flutter/material.dart';
import 'package:hamro_cinema/models/movie.dart';
import 'package:hamro_cinema/screens/movies_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie, required this.id})
      : super(key: key);

  final Movie movie;
  final int id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () => navigate(
        context,
        MovieScreen(id: id),
      ),
      child: Column(
        children: [
          Image.network(
            movie.coverImage,
            height: size.height * .21,
            width: size.width * .42,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            movie.movieName,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
