import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../utils/constants.dart';
import '../route_builder.dart';
import './widgets.dart';

/// Creates the coin widget in swipe bar.
class Coin extends StatelessWidget {
  /// Parent generates [iconSize].
  final double iconSize;

  /// Constructor
  Coin(this.iconSize);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(gestureDetectorRouteBuilder(
                context,
                Hero(
                  tag: 'coin',
                  child: ShakeWidget(coin),
                ),
                () => BlocProvider.of<CoinBloc>(context).add(CoinFlipEvent())))
            .then(
          (_) {
            BlocProvider.of<SwipeBarBloc>(context).add(SwipeBarResetEvent());
            BlocProvider.of<CoinBloc>(context).add(CoinResetEvent());
          },
        );
      },
      child: Hero(
        tag: 'coin',
        child: Image(
          image: AssetImage('assets/coins/base.png'),
          width: iconSize,
        ),
      ),
    );
  }
}
