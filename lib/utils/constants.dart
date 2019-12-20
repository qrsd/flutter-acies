import 'package:flutter/material.dart';

/// Constants used throughout app.
// ignore_for_file: public_member_api_docs
const die = 0;
const coin = 1;
const calculatorHistory = 0;
const gameListHistory = 1;
const swipeBarStart = 0.033;
const swipeBarEnd = -.09;
const playerOneVal = 0;
const playerTwoVal = 1;
const startLifePoints = 8000;
const timerMinutes = 40;
const primaryColor = Color(0xFF212327);
const secondaryColor = Color(0xFF947FFD);
const aboutText =
    'acies is a minamalist approach to a Yu-Gi-Oh! Life Point Calculator with all features usually included. It also includes a match history and note taking feature.';
const iconText =
    'Icons made by Freepik, Gregor Cresnar, SmashIcons from flaticon.com and icons8.com';

ThemeData themeData = ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: primaryColor,
  accentColor: primaryColor,
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
