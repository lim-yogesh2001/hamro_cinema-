import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hamro_cinema/providers/login_provider.dart';
import 'package:hamro_cinema/providers/movies_watched_provider.dart';
import 'package:hamro_cinema/widgets/curved_body_widget.dart';
import 'package:intl/intl.dart';
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
                          ListView.builder(
                            primary: false,
                            itemCount: data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                // ListTile(
                                //   leading: ClipRRect(
                                //     borderRadius: BorderRadius.circular(25),
                                //     child: Image.network(data[index].coverImage),
                                //   ),
                                //   title: Text(data[index].movieName),
                                //   subtitle: Text(data[index].theaterName),
                                //   trailing: Text(
                                //       "Seat: ${data[index].row} ${data[index].number}"),
                                // ),
                                Card(
                              elevation: 5,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    width:
                                        MediaQuery.of(context).size.width * .35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child:
                                          Image.network(data[index].coverImage),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .02,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            data[index].movieName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Theater Name: " +
                                                data[index].theaterName,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .01,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Row: ${data[index].row}, Seat No: ${data[index].number}",
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .01,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Time: ${DateFormat("yyyy-MM-dd").format(data[index].date)} ${data[index].showTime}",
                                          ),
                                        )
                                      ],
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
