import 'package:flutter/material.dart';

const swipeBarStart = 0.033;
const swipeBarEnd = -.09;
const playerOneVal = 0;
const playerTwoVal = 1;
const startLifePoints = 8000;
const timerMinutes = 40;
const primaryColor = const Color(0xFF212327);
const secondaryColor = const Color(0xFF947FFD);

ThemeData themeData = ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: primaryColor,
  highlightColor: secondaryColor,
  splashColor: secondaryColor,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  textTheme: TextTheme(
    body1: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
    button: TextStyle(
      color: Colors.white,
    ),
    subhead: TextStyle(
      color: Colors.white,
    ),
  ),
);
