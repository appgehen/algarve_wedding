import 'package:flutter/material.dart';

ThemeData darkThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color.fromRGBO(59, 113, 163, 1),
    accentColor: Color.fromRGBO(59, 113, 163, 1),
    cursorColor: Color.fromRGBO(59, 113, 163, 1),
    textSelectionColor: Color.fromRGBO(59, 113, 163, 1),
    textSelectionHandleColor: Color.fromRGBO(59, 113, 163, 1),
    focusColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Color.fromRGBO(33, 33, 33, 1),
      textTheme: TextTheme(
        caption: TextStyle(
          fontSize: 18.0,
          fontFamily: 'Roboto Light',
          color: Colors.white,
        ),
      ),
    ),
    dialogBackgroundColor: Color.fromRGBO(33, 33, 33, 1),
    backgroundColor: Color.fromRGBO(66, 66, 66, 1),
    fontFamily: 'Roboto Light',
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: TextStyle(
        color: Colors.red[500],
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Amatic Regular',
        height: 1.5,
        fontSize: 35,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
      ),
      headline3: TextStyle(
        fontFamily: 'Amatic Regular',
        height: 1.2,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Colors.black,
            offset: Offset(1, 1),
          ),
        ],
      ),
      headline4: TextStyle(
        fontFamily: 'Amatic Regular',
        fontWeight: FontWeight.bold,
        fontSize: 60.0,
        color: Color.fromRGBO(59, 113, 163, 1),
      ),
      headline5: TextStyle(
        fontFamily: 'Amatic Regular',
        color: Colors.white,
        height: 1.2,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Colors.black,
            offset: Offset(1, 1),
          ),
        ],
      ),
      headline6: TextStyle(
        fontFamily: 'Amatic Regular',
        color: Colors.white,
        height: 1.2,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Colors.black,
            offset: Offset(1, 1),
          ),
        ],
      ),
      bodyText1: TextStyle(
        fontSize: 15.0,
        height: 1.5,
        fontFamily: 'Roboto Light',
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 15.0,
        height: 1.5,
        fontFamily: 'Roboto Light',
        color: Colors.white,
      ),
      subtitle2: TextStyle(
        height: 1.5,
        color: Colors.white,
        fontFamily: 'Roboto Light',
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}
