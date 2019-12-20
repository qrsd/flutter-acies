import 'package:flutter/material.dart';

/// Top bar widget for the help screen.
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var topBarIconSize = MediaQuery.of(context).size.width / 13;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: topBarIconSize,
          ),
        ),
        SizedBox(),
        SizedBox(),
        Text(
          'help',
          style: TextStyle(
            fontSize: (MediaQuery.of(context).size.width) / 14,
          ),
        ),
        SizedBox(),
        SizedBox(),
        SizedBox(),
        SizedBox(),
      ],
    );
  }
}
