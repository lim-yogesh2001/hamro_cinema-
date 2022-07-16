import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.green,
    iconTheme: const IconThemeData(color: Colors.blue),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      elevation: 0,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      TextTheme(
        headline5: const TextStyle(
          color: Colors.black,
          fontFamily: "Open Sans",
          fontWeight: FontWeight.w600,
        ),
        headline2: const TextStyle(color: Colors.black),
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        subtitle1: const TextStyle(
          color: Colors.black,
        ),
        subtitle2: const TextStyle(
          color: Colors.black,
        ),
        caption: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 8,
      ),
      hintStyle: TextStyle(
        fontSize: 16,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueAccent,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            15,
          ),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueAccent,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            15,
          ),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            15,
          ),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            15,
          ),
        ),
      ),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black38,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        color: Colors.white,
        fontFamily: "Open Sans",
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white, fontFamily: "Open Sans"),
      bodyText2: TextStyle(color: Colors.white),
      subtitle1: TextStyle(
        color: Colors.white,
        fontFamily: "Open Sans",
      ),
      subtitle2: TextStyle(
        color: Colors.white,
      ),
      caption: TextStyle(
        color: Colors.white,
        fontFamily: "Open Sans",
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        )),
  );
}
