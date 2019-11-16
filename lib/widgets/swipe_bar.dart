import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';
import './widgets.dart';

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
        child: Column(
          children: <Widget>[
            BlocBuilder<SwipeBarBloc, SwipeBarState>(
              builder: (context, state) {
                return Icon(
                  state is SwipeBarTop
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: Colors.black,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Coin(),
                Dice(),
                const Icon(
                  Icons.history,
                  size: 30,
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<TopBarBloc>(context)
                        .add(TopBarResetEvent());
                    BlocProvider.of<CalculatorBloc>(context)
                        .add(CalculatorResetEvent());
                    BlocProvider.of<TimerBloc>(context).add(TimerResetEvent());
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
