import 'package:flutter/material.dart';
import 'package:hamro_cinema/constants/constants.dart';
import 'package:hamro_cinema/models/movie.dart';
import 'package:hamro_cinema/providers/review_provider.dart';
import 'package:hamro_cinema/providers/seat_provider.dart';
import 'package:hamro_cinema/providers/show_provider.dart';
import 'package:hamro_cinema/providers/ticket_provider.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import '/providers/education_provider.dart';
import '/providers/login_provider.dart';
import 'providers/movie_provider.dart';
import '/providers/register_provider.dart';
import '/screens/login_screen.dart';
import '/theme/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // "cinema"

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: khaltiPublicKey,
      builder: (context, navigatorKey) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RegisterProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => LoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => MovieProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ShowProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SeatProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => TicketProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ReviewProvider(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Hamro Cinema',
          theme: lightTheme(context),
          home: LoginScreen(),
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
