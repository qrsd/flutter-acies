import 'package:flutter/material.dart';

const PLAYER_1 = 0;
const PLAYER_2 = 1;
const START_LP = 8000;
const TIMER_MINUTES = 45;
const WIP_MESSAGE =
    Text('This feature is a W.I.P. and is not currently implemented');
const PRIMARY_COLOR = const Color(0xff212327);
const SECONDARY_COLOR = const Color(0xFF947FFD);

RichText TIMER_INSTRUCTIONS = RichText(
  text: TextSpan(children: <TextSpan>[
    TextSpan(
      text: 'Tap           :',
      style: TextStyle(wordSpacing: 1.1),
    ),
    TextSpan(
      text: ' Display Instructions\n',
    ),
    TextSpan(
      text: 'Double Tap : Start Timer\n',
    ),
    TextSpan(
      text: 'Long Press : Pause Timer\n',
    ),
    TextSpan(
      text: 'Drag          :',
      style: TextStyle(wordSpacing: 1),
    ),
    TextSpan(
      text: ' Reset Timer',
    ),
  ]),
);

ThemeData THEME = ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: PRIMARY_COLOR,
  highlightColor: SECONDARY_COLOR,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  textTheme: TextTheme(
    body1: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
    body2: TextStyle(
      color: Colors.white,
    ),
    headline: TextStyle(
      color: Colors.white,
    ),
    button: TextStyle(
      color: Colors.white,
    ),
    title: TextStyle(
      color: Colors.white,
    ),
    subhead: TextStyle(
      color: Colors.white,
    ),
    display1: TextStyle(
      color: Colors.white,
    ),
  ),
  primaryTextTheme: TextTheme(
      body1: TextStyle(
        color: Colors.white,
      ),
      button: TextStyle(
        color: Colors.white,
      )),
);

//<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a></div>
//<div>Icons made by <a href="https://www.flaticon.com/authors/gregor-cresnar" title="Gregor Cresnar">Gregor Cresnar</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a></div>
