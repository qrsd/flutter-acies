import 'package:flutter/material.dart';

import './widgets.dart';
import '../utils/constants.dart';
import '../utils/key_values.dart';

class Pad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .506,
        color: PRIMARY_COLOR,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                KeyButton(KeyValues.half0),
                KeyButton(KeyValues.clear),
                KeyButton(KeyValues.half1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                KeyButton(KeyValues.seven),
                KeyButton(KeyValues.eight),
                KeyButton(KeyValues.nine),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                KeyButton(KeyValues.four),
                KeyButton(KeyValues.five),
                KeyButton(KeyValues.six),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                KeyButton(KeyValues.one),
                KeyButton(KeyValues.two),
                KeyButton(KeyValues.three),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                KeyButton(KeyValues.zero),
                KeyButton(KeyValues.doubleZero),
                KeyButton(KeyValues.tripleZero),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
