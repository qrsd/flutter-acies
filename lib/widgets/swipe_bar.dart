import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import './widgets.dart';
import '../utils/constants.dart';

class SwipeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/scroll/0.png'), context);
    precacheImage(AssetImage('assets/scroll/1.png'), context);
    precacheImage(AssetImage('assets/scroll/2.png'), context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * .12,
        color: SECONDARY_COLOR,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: const Alignment(0, -1),
              child: BlocBuilder<SwipeBarBloc, SwipeBarState>(
                builder: (context, state) {
                  return Icon(
                    state.props[0] == SWIPE_BAR_END
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.black,
                    size: 40,
                  );
                },
              ),
            ),
            Align(
              alignment: const Alignment(0, .239),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Coin(),
                  Dice(),
                  History(),
                  ResetButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
