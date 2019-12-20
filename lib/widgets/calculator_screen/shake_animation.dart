import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../utils/constants.dart';

/// Shake animation used by dice and coin widgets.
class ShakeWidget extends StatefulWidget {
  /// [type] tells you which widget you are shaking.
  final int type;

  /// Constructor
  ShakeWidget(this.type);

  @override
  _ShakeWidgetState createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  final int animationDuration = 500;
  double aniEnd;
  Animation<double> _animation;
  AnimationController _animationController;
  Tween _tween;

  @override
  void initState() {
    super.initState();
    aniEnd = 8;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
    _tween = Tween<double>(
      begin: 0,
      end: aniEnd,
    );
    _animation = _tween
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_animationController)
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                _animationController.reverse();
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == die) {
      return BlocBuilder<DieBloc, DieState>(
        builder: (context, state) {
          if (!(state is DieInitial)) {
            _animationController.forward(from: 0);
          }
          return AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Padding(
                padding: EdgeInsets.only(
                    left: _animation.value + aniEnd,
                    right: aniEnd - _animation.value),
                child: Image(
                  image: AssetImage(
                    'assets/dice/${state.props[0]}.png',
                  ),
                  width: MediaQuery.of(context).size.width * .4,
                ),
              );
            },
          );
        },
      );
    } else {
      return BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          if (!(state is CoinInitial)) {
            _animationController.forward(from: 0);
          }
          return AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Padding(
                padding: EdgeInsets.only(
                    left: _animation.value + aniEnd,
                    right: aniEnd - _animation.value),
                child: Image(
                  image: AssetImage(
                    'assets/coins/${state.props[0]}.png',
                  ),
                  width: MediaQuery.of(context).size.width * .4,
                ),
              );
            },
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
