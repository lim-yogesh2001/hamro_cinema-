import 'package:flutter/material.dart';
import 'package:hamro_cinema/providers/movie_provider.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:hamro_cinema/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class RecommendedMoviesScreen extends StatelessWidget {
  const RecommendedMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<MovieProvider>(context, listen: false)
        .fetchRecommendedMovies(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended Movies"),
      ),
      body: CurvedBodyWidget(
          widget: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recommended Movies",
              style: Theme.of(context).textTheme.headline6,
            ),
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Consumer<MovieProvider>(
                  builder: (context, value, child) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (_, index) {
                      return MovieCard(
                        movie: value.recommendedMovies[index],
                        id: value.recommendedMovies[index].id,
                      );
                    },
                    itemCount: value.recommendedMovies.length,
                    shrinkWrap: true,
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
