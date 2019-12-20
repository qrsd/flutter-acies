import 'package:acies/utils/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/about/widgets.dart';

/// About this app screen.
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TopBar(),
          ),
          Align(
            alignment: Alignment(0, -.8),
            child: Image.asset(
              'assets/splash.png',
              width: MediaQuery.of(context).size.width / 2.5,
            ),
          ),
          Align(
            alignment: Alignment(0, -.2),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(aboutText),
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                iconText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
