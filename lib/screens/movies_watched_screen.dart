import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hamro_cinema/providers/login_provider.dart';
import 'package:hamro_cinema/providers/movies_watched_provider.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:provider/provider.dart';

class MoviesWatchedScreen extends StatelessWidget {
  const MoviesWatchedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId =
        Provider.of<LoginProvider>(context, listen: false).user!.user.id;
    final future = Provider.of<MoviesWatchedProvider>(context, listen: false)
        .fetchWatchedMovies(userId);
    return Scaffold(
      appBar: AppBar(title: const Text("Watched Movies")),
      body: CurvedBodyWidget(
        widget: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data =
                  Provider.of<MoviesWatchedProvider>(context, listen: false)
                      .moviesWatched;
              return data.isEmpty
                  ? Center(
                      child: Text(
                        "No past movies watched",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text("Your Past Watched Movies"),
                          const SizedBox(
                            height: 16,
                          ),
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Card(
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child:
                                        Image.network(data[index].coverImage),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      data[index].movieName,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
