import 'package:flutter/material.dart';

ThemeData lightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromRGBO(33, 62, 90, 1),
    accentColor: Color.fromRGBO(33, 62, 90, 1),
    cursorColor: Color.fromRGBO(33, 62, 90, 1),
    textSelectionColor: Color.fromRGBO(33, 62, 90, 1),
    textSelectionHandleColor: Color.fromRGBO(33, 62, 90, 1),
    focusColor: Colors.black,
    dialogBackgroundColor: Color.fromRGBO(33, 33, 33, 1),
    appBarTheme: AppBarTheme(
      color: Color.fromRGBO(33, 62, 90, 1),
      textTheme: TextTheme(
        title: TextStyle(
          fontSize: 18.0,
          fontFamily: 'Roboto Light',
          color: Colors.white,
        ),
      ),
    ),
    backgroundColor: Colors.white,
    fontFamily: 'Roboto Light',
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Amatic Regular',
        color: Colors.black,
        height: 1.5,
        fontSize: 35,
      ),
      headline2: TextStyle(
        fontSize: 18.0,
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
        color: Color.fromRGBO(33, 62, 90, 1),
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
      ),
      bodyText2: TextStyle(
        fontSize: 15.0,
        height: 1.5,
        color: Colors.white,
      ),
      subtitle2: TextStyle(
        height: 1.5,
      ),
    ),
  );
}
