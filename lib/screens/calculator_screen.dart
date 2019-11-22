import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';
import '../widgets/widgets.dart';

class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: const Alignment(0, -1),
              child: TopBar(),
            ),
          ),
          Align(
            alignment: const Alignment(0, -.72),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PlayerColumn(PLAYER_1),
                CenterColumn(),
                PlayerColumn(PLAYER_2),
              ],
            ),
          ),
          BlocBuilder<SwipeBarBloc, SwipeBarState>(
            builder: (context, state) {
              return GestureDetector(
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  BlocProvider.of<SwipeBarBloc>(context)
                      .add(SwipeBarMovingEvent(details.primaryDelta));
                },
                child: Align(
                  alignment: Alignment(0, state.props[0]),
                  child: SwipeBar(),
                ),
              );
            },
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: Pad(),
          ),
          SnackBars(),
        ],
      ),
    );
  }
}
