import 'package:flutter/material.dart';
import 'package:hamro_cinema/providers/movie_provider.dart';
import 'package:hamro_cinema/screens/shows_screen.dart';
import 'package:hamro_cinema/utils/navigate.dart';
import 'package:intl/intl.dart';
import '/widgets/curved_body_widget.dart';

import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MovieProvider>(context).getMovieById(id);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.movieName),
      ),
      body: CurvedBodyWidget(
        widget: ListView(
          children: [
            SizedBox(
              height: size.height * .4,
              width: size.width,
              child: Image.network(
                movie.coverImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Description : ${movie.descripton}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Casts : ${movie.casts}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Release Date : ${DateFormat("yyyy-MMMM-dd").format(movie.releaseDate)}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 16,
            ),
             Text(
              "Genres : ${movie.genres}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
             const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => navigate(
                context,
                ShowsScreen(
                  movieId: movie.id,
                ),
              ),
              child: const Text("Get Shows"),
            ),
            const SizedBox(
              height: 16,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       height: 25.h,
            //       width: 25.h,
            //       color: Colors.grey.shade200,
            //       child: IconButton(
            //         padding: EdgeInsets.zero,
            //         onPressed: () {
            //           if (movie.selectedQuantity < movie.quantity) {
            //             Provider.of<ProductsProvider>(context, listen: false)
            //                 .updateQuantity(id, movie.selectedQuantity + 1);
            //           }
            //         },
            //         icon: const Icon(
            //           Icons.add_outlined,
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 10.w,
            //     ),
            //     Text(
            //       movie.selectedQuantity.toString(),
            //       style: Theme.of(context).textTheme.subtitle1,
            //     ),
            //     SizedBox(
            //       width: 10.w,
            //     ),
            //     Container(
            //       height: 25.h,
            //       width: 25.h,
            //       color: Colors.grey.shade200,
            //       child: IconButton(
            //         padding: EdgeInsets.zero,
            //         onPressed: () {
            //           if (movie.selectedQuantity > 0) {
            //             Provider.of<ProductsProvider>(context, listen: false)
            //                 .updateQuantity(id, movie.selectedQuantity - 1);
            //           }
            //         },
            //         icon: const Icon(
            //           Icons.remove_outlined,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 16.h,
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     if (movie.selectedQuantity == 0) {
            //       showSnackBar(context, "Please select your quantity");
            //     } else {
            //       ScaffoldMessenger.of(context).clearSnackBars();
            //     }
            //   },
            //   child: const Text("Buy"),
            //   style: ElevatedButton.styleFrom(
            //     // alignment:
            //     primary: Theme.of(context).primaryColor,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
