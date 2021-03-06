import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../utils/constants.dart';
import '../route_builder.dart';
import './widgets.dart';

/// Creates the dice widget in swipe bar.
class Dice extends StatelessWidget {
  /// [iconSize] is generated by parent.
  final double iconSize;

  /// Constructor
  Dice(this.iconSize);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(gestureDetectorRouteBuilder(
                context,
                Hero(
                  tag: 'die',
                  child: ShakeWidget(die),
                ),
                () => BlocProvider.of<DieBloc>(context).add(DieRollEvent())))
            .then(
          (_) {
            BlocProvider.of<SwipeBarBloc>(context).add(SwipeBarResetEvent());
            BlocProvider.of<DieBloc>(context).add(DieResetEvent());
          },
        );
      },
      child: Hero(
        tag: 'die',
        child: Image(
          image: AssetImage('assets/dice/0.png'),
          width: iconSize,
        ),
      ),
    );
  }
}
