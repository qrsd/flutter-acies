import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class SwipeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Container(
        height: 80,
        color: Color(0xFF947FFD),
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
                InkWell(
                  splashColor: Colors.grey,
                  onTap: () {},
                  child: Image.asset(
                    'assets/coins.png',
                    width: 30,
                  ),
                ),
                Image.asset(
                  'assets/dice.png',
                  width: 30,
                ),
                Icon(
                  Icons.history,
                  size: 30,
                  color: Colors.white,
                ),
                Text(
                  'Reset',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
