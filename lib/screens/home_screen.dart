import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamro_cinema/providers/login_provider.dart';
import 'package:hamro_cinema/providers/movie_provider.dart';
import 'package:hamro_cinema/screens/profile_screen.dart';
import 'package:hamro_cinema/widgets/general_alert_dialog.dart';
import 'package:hamro_cinema/widgets/movie_card.dart';
import 'package:provider/provider.dart';

import '/utils/navigate.dart';
import '/widgets/curved_body_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<LoginProvider>(context, listen: false).user;
    // final future =
    //     Provider.of<RoomProvider>(context, listen: false).fetchRoom(context);
    final movieFuture =
        Provider.of<MovieProvider>(context, listen: false).fetchMovies();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Home!"),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          // Consumer<UserProvider>(builder: (_, data, __) {
          //   // data.
          //   return
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
          const Spacer(),
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
