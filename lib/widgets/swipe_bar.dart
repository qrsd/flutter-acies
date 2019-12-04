import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './widgets.dart';
import '../blocs/blocs.dart';
import '../utils/constants.dart';

class SwipeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/scroll/0.png'), context);
    precacheImage(AssetImage('assets/scroll/1.png'), context);
    precacheImage(AssetImage('assets/scroll/2.png'), context);
    double swipeBarIconSize;
    double swipeBarArrowIconSize;
    if (MediaQuery.of(context).size.width >= 600) {
      swipeBarIconSize = MediaQuery.of(context).size.width / 15;
      swipeBarArrowIconSize = MediaQuery.of(context).size.width / 15;
    } else {
      swipeBarIconSize = 35;
      swipeBarArrowIconSize = 35;
    }
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * .1,
        color: secondaryColor,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: const Alignment(0, -1),
              child: BlocBuilder<SwipeBarBloc, SwipeBarState>(
                builder: (_, state) {
                  return Icon(
                    state.props[0] == swipeBarEnd
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.black,
                    size: swipeBarArrowIconSize,
                  );
                },
              ),
            ),
            Align(
              alignment: const Alignment(0, .35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Coin(swipeBarIconSize),
                  Dice(swipeBarIconSize),
                  History(swipeBarIconSize),
                  ResetButton(swipeBarIconSize),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
