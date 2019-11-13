import 'package:flutter/material.dart';

import '../utils/key_values.dart';
import './widgets.dart';

class Pad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xff212327),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  KeyButton(KeyValues.half0),
                  KeyButton(KeyValues.clear),
                  KeyButton(KeyValues.half1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  KeyButton(KeyValues.seven),
                  KeyButton(KeyValues.eight),
                  KeyButton(KeyValues.nine),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  KeyButton(KeyValues.four),
                  KeyButton(KeyValues.five),
                  KeyButton(KeyValues.six),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  KeyButton(KeyValues.one),
                  KeyButton(KeyValues.two),
                  KeyButton(KeyValues.three),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  KeyButton(KeyValues.zero),
                  KeyButton(KeyValues.doubleZero),
                  KeyButton(KeyValues.tripleZero),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
