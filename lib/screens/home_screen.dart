import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hamro_cinema/screens/movies_watched_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '/providers/login_provider.dart';
import '/providers/movie_provider.dart';
import '/providers/weather_provider.dart';
import '/screens/list_of_theater_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/recommended_movies_screen.dart';
import '/utils/navigate.dart';
import '/widgets/curved_body_widget.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/movie_card.dart';
import '/widgets/upcoming_movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoginProvider>(context, listen: false).user;
    final movieFuture =
        Provider.of<MovieProvider>(context, listen: false).fetchMovies();
    final upcomingMovieFuture =
        Provider.of<MovieProvider>(context, listen: false)
            .fetchUpcomingMovies();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Home!"),
        actions: [
          if (Provider.of<WeatherProvider>(context, listen: false).weather !=
              null)
            Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: Text(
                "${Provider.of<WeatherProvider>(context, listen: false).weather!.name} ${Provider.of<WeatherProvider>(context, listen: false).weather!.main.temp.toStringAsFixed(2)} \u00B0C",
              ),
            ),
        ],
      ),
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(data?.user.username ?? "No Name"),
            accountEmail: Text(
              data?.user.email ?? "No Email",
            ),
            currentAccountPicture: const Icon(
              Icons.person_outlined,
              color: Colors.white,
              size: 48,
            ),
          ),
          buildListTile(
            context,
            label: "Profile",
            widget: const ProfileScreen(),
          ),
          const SizedBox(
            height: 8,
          ),
          buildListTile(
            context,
            label: "Recommended Movies",
            widget: const RecommendedMoviesScreen(),
          ),
          const SizedBox(
            height: 8,
          ),
          buildListTile(
            context,
            label: "List of Theaters",
            widget: const ListOfTheaterScreen(),
          ),
          const SizedBox(
            height: 8,
          ),
          buildListTile(
            context,
            label: "Watched Movies History",
            widget: const MoviesWatchedScreen(),
          ),
          const SizedBox(
            height: 8,
          ),
          buildListTile(
            context,
            label: "Log Out",
            func: () async {
              try {
                Provider.of<LoginProvider>(context, listen: false)
                    .logout(context);
              } catch (ex) {
                GeneralAlertDialog().customAlertDialog(context, ex.toString());
              }
            },
          ),
        ],
      )),
      body: CurvedBodyWidget(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Hello! ${data!.user.username}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Text(
                    DateFormat("yyyy MMM dd hh:mm a").format(
                      DateTime.now(),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Upcoming Movies",
                style: Theme.of(context).textTheme.headline6,
              ),
              FutureBuilder(
                future: upcomingMovieFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer<MovieProvider>(
                    builder: (context, value, child) =>
                        value.upcomingMovies.isEmpty
                            ? const SizedBox.shrink()
                            : CarouselSlider.builder(
                                itemCount: value.upcomingMovies.length,
                                itemBuilder: (context, i, index) {
                                  return UpcomingMovieCard(
                                    movie: value.upcomingMovies[i],
                                  );
                                },
                                options: CarouselOptions(
                                  viewportFraction: 0.8,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                ),
                              ),
                    // GridView.builder(
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //     childAspectRatio: 0.75,
                    //   ),
                    //   itemBuilder: (_, index) {
                    //     return MovieCard(
                    //       movie: value.listOfMovies[index],
                    //       id: value.listOfMovies[index].id,
                    //     );
                    //   },
                    //   itemCount: value.listOfMovies.length,
                    //   shrinkWrap: true,
                    // ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Now Showing",
                style: Theme.of(context).textTheme.headline6,
              ),
              FutureBuilder(
                future: movieFuture,
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
                          movie: value.listOfMovies[index],
                          id: value.listOfMovies[index].id,
                        );
                      },
                      itemCount: value.listOfMovies.length,
                      shrinkWrap: true,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(
    BuildContext context, {
    required String label,
    Widget? widget,
    Function? func,
  }) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_right_outlined,
      ),
      onTap: () {
        if (widget != null) {
          navigate(context, widget);
        } else {
          func!();
        }
      },
    );
  }
}
