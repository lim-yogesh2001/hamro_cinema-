import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hamro_cinema/constants/constants.dart';
import 'package:hamro_cinema/providers/movies_watched_provider.dart';
import 'package:hamro_cinema/providers/review_provider.dart';
import 'package:hamro_cinema/providers/seat_provider.dart';
import 'package:hamro_cinema/providers/show_provider.dart';
import 'package:hamro_cinema/providers/theater_provider.dart';
import 'package:hamro_cinema/providers/ticket_provider.dart';
import 'package:hamro_cinema/providers/weather_provider.dart';
import 'package:hamro_cinema/screens/splash_screen.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import '/providers/login_provider.dart';
import 'providers/movie_provider.dart';
import '/providers/register_provider.dart';
import '/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // "cinema"

  // This widget is the root of your application.

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  configureMessaging() async {
    final messagingInstance = FirebaseMessaging.instance;
    final permission = await messagingInstance.requestPermission();

    await messagingInstance.subscribeToTopic("cinema");

    // messagingInstance.
    FirebaseMessaging.onMessage.forEach(
      (event) {
        const androidNotification = AndroidNotificationDetails(
          "channel id",
          "channel name",
          importance: Importance.high,
          priority: Priority.high,
        );

        const notificationDetails =
            NotificationDetails(android: androidNotification);

        flutterLocalNotificationsPlugin.show(
          Random().nextInt(100000),
          event.notification?.title ?? "title",
          event.notification?.body ?? "body",
          notificationDetails,
        );
      },
    );
  }

  configureNotification() {
    const androidSettings = AndroidInitializationSettings("mipmap/ic_launcher");
    const iosSettings = IOSInitializationSettings();

    const initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    configureMessaging();
    configureNotification();
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
            create: (_) => TheaterProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ReviewProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => WeatherProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => MoviesWatchedProvider(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Hamro Cinema',
          theme: lightTheme(context),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
