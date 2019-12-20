import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../../utils/constants.dart';
import './widgets.dart';

/// Creates both player columns.
class PlayerColumn extends StatelessWidget {
  /// [player] id.
  final int player;

  /// Constructor
  PlayerColumn(this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          PlayerField(player),
          LifePoints(player),
          KeyButton(player == playerOneVal ? add0 : add1),
          KeyButton(player == playerOneVal ? min0 : min1),
        ],
      ),
    );
  }
}

/// Text form field for each player.
class PlayerField extends StatelessWidget {
  /// [player] id
  final int player;

  /// Constructor
  PlayerField(this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: TextFormField(
        autocorrect: false,
        inputFormatters: [LengthLimitingTextInputFormatter(8)],
        initialValue: player == playerOneVal ? 'You' : 'Opponent',
        style: TextStyle(fontSize: (MediaQuery.of(context).size.width) / 18),
        textAlign: TextAlign.center,
        cursorColor: secondaryColor,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: secondaryColor,
            ),
          ),
        ),
        onFieldSubmitted: (name) {
          SystemChrome.restoreSystemUIOverlays();
          BlocProvider.of<HistoryBloc>(context)
              .add(HistoryNameChangeEvent(player, name));
        },
      ),
    );
  }
}

/// Responsible for each player's life points and the animation.
class LifePoints extends StatefulWidget {
  /// [player] id
  final int player;

  /// Constructor
  LifePoints(this.player);

  @override
  _LifePointsState createState() => _LifePointsState();
}

class _LifePointsState extends State<LifePoints>
    with SingleTickerProviderStateMixin {
  final int animationDuration = 2000;
  Animation<int> _lifePointsAnimation;
  AnimationController _animationController;
  IntTween _tween;
  int _animationDelta;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
    _tween = IntTween(
      begin: 8000,
      end: 8000,
    );
    _lifePointsAnimation = _tween.animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (_, state) {
        if (widget.player == playerOneVal && state is CalculatorP1LPUpdate ||
            (widget.player == playerTwoVal && state is CalculatorP2LPUpdate)) {
          _animationDelta = state.props[0];
          _tween.begin = _tween.end;
          _tween.end = _animationDelta;
          _animationController.forward(from: 0);
        } else if (state is CalculatorInitial) {
          _tween.end = _animationDelta = 8000;
        }
        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            return Text(_lifePointsAnimation.value.toString(),
                style: TextStyle(
                  fontSize: (MediaQuery.of(context).size.width) / 10,
                  color: _animationController.isAnimating
                      ? (_animationDelta > _lifePointsAnimation.value
                          ? Colors.green
                          : _animationDelta < _lifePointsAnimation.value
                              ? Colors.red
                              : null)
                      : null,
                ));
          },
        );
      },
    );
  }
}

/// Center column, delta for life points.
class CenterColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      width: MediaQuery.of(context).size.width / 3,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: const Alignment(0, 0),
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (_, state) {
                String centerText;
                if (!(state is CalculatorMiddleUpdate) ||
                    state.props[0] == null) {
                  centerText = '0000';
                } else {
                  centerText = state.props[0];
                }
                return Text(
                  centerText,
                  style: TextStyle(
                    fontSize: (MediaQuery.of(context).size.width) / 10,
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                KeyButton(win0),
                KeyButton(win1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
