import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './widgets.dart';
import '../blocs/blocs.dart';
import '../utils/constants.dart';

class SwipeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        height: 80,
        color: SECONDARY_COLOR,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: const Alignment(0, -1),
              child: BlocBuilder<SwipeBarBloc, SwipeBarState>(
                builder: (context, state) {
                  return Icon(
                    state is SwipeBarTop
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.black,
                  );
                },
              ),
            ),
            Align(
              alignment: const Alignment(0, -.09),
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
