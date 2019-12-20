import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../utils/constants.dart';
import './widgets.dart';

/// Creates the key pad widget, which is a container of most key buttons.
class Pad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        color: primaryColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                KeyButton(half0),
                KeyButton(clear),
                KeyButton(half1),
              ],
            ),
            Row(
              children: <Widget>[
                KeyButton(seven),
                KeyButton(eight),
                KeyButton(nine),
              ],
            ),
            Row(
              children: <Widget>[
                KeyButton(four),
                KeyButton(five),
                KeyButton(six),
              ],
            ),
            Row(
              children: <Widget>[
                KeyButton(one),
                KeyButton(two),
                KeyButton(three),
              ],
            ),
            Row(
              children: <Widget>[
                KeyButton(zero),
                KeyButton(doubleZero),
                KeyButton(tripleZero),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
