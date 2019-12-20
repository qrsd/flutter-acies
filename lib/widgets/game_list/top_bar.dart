import 'dart:math';
import 'package:flutter/material.dart';

import '../route_builder.dart';
import './widgets.dart';

/// Top Bar widget for game list screen.
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var topBarIconSize = MediaQuery.of(context).size.width / 13;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          onTap: () => Navigator.of(context).push(fullRouteBuilder(
              context, SettingsDrawer(), Offset(-1, 0.0), Offset(-.5, 0.0))),
          child: Icon(
            Icons.menu,
            size: topBarIconSize,
          ),
        ),
        SizedBox(),
        SizedBox(),
        SizedBox(),
        SizedBox(),
        SizedBox(),
        Transform.rotate(
          angle: pi,
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios,
              size: topBarIconSize,
            ),
          ),
        ),
      ],
    );
  }
}
