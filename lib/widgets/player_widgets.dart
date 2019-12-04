import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './widgets.dart';
import '../blocs/blocs.dart';
import '../utils/constants.dart';
import '../utils/key_values.dart';

class PlayerColumn extends StatelessWidget {
  final int player;

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
          KeyButton(player == playerOne ? KeyValues.add0 : KeyValues.add1),
          KeyButton(player == playerOne ? KeyValues.min0 : KeyValues.min1),
        ],
      ),
    );
  }
}

class PlayerField extends StatelessWidget {
  final int player;

  PlayerField(this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: TextFormField(
        autocorrect: false,
        inputFormatters: [LengthLimitingTextInputFormatter(8)],
        initialValue: this.player == playerOne ? 'You' : 'Opponent',
        style: TextStyle(fontSize: (MediaQuery.of(context).size.width) / 18),
        textAlign: TextAlign.center,
        cursorColor: secondaryColor,
        decoration: const InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: secondaryColor,
            ),
          ),
        ),
        onFieldSubmitted: (name) {
          SystemChrome.restoreSystemUIOverlays();
          BlocProvider.of<HistoryBloc>(context)
              .add(HistoryNameChangeEvent(this.player, name));
        },
      ),
    );
  }
}

class LifePoints extends StatefulWidget {
  final int player;

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
        if (widget.player == playerOne && state is CalculatorP1LPUpdate ||
            (widget.player == playerTwo && state is CalculatorP2LPUpdate)) {
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

class CenterColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      width: MediaQuery.of(context).size.width / 3,
      child: Stack(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: const Alignment(0, 0),
            child: BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (_, state) {
                String centerText;
                if (!(state is CalculatorMiddleUpdate) ||
                    state.props[0] == null)
                  centerText = '0000';
                else
                  centerText = state.props[0];
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
                KeyButton(KeyValues.win0),
                KeyButton(KeyValues.win1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
