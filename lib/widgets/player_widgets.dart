import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import './widgets.dart';
import '../utils/constants.dart';
import '../utils/key_values.dart';

class PlayerColumn extends StatelessWidget {
  final int player;

  PlayerColumn(this.player);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Players(player),
            LifePoints(player),
            KeyButton(player == PLAYER_1 ? KeyValues.add0 : KeyValues.add1),
            KeyButton(player == PLAYER_1 ? KeyValues.min0 : KeyValues.min1),
          ],
        ),
      ),
    );
  }
}

class Players extends StatelessWidget {
  final int player;

  Players(this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: TextFormField(
        autocorrect: false,
        inputFormatters: [LengthLimitingTextInputFormatter(8)],
        initialValue: this.player == PLAYER_1 ? 'You' : 'Opponent',
        style: TextStyle(fontSize: 22),
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(
              color: SECONDARY_COLOR,
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

class LifePoints extends StatefulWidget {
  final int player;

  LifePoints(this.player);

  @override
  _LifePointsState createState() => _LifePointsState();
}

class _LifePointsState extends State<LifePoints>
    with SingleTickerProviderStateMixin {
  final int animationDuration = 2000;
  Animation<int> lpAnimation;
  AnimationController _animationController;
  IntTween _tween;
  int _aniDelta;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationDuration),
    );
    _tween = IntTween(
      begin: 8000,
      end: 8000,
    );
    lpAnimation = _tween.animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        if (widget.player == PLAYER_1 && state is CalculatorP1LPUpdate ||
            (widget.player == PLAYER_2 && state is CalculatorP2LPUpdate)) {
          _aniDelta = state.props[0];
          _tween.begin = _tween.end;
          _tween.end = _aniDelta;
          _animationController.forward(from: 0);
        } else if (state is CalculatorInitial) {
          _tween.end = 8000;
        }
        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            return Text(lpAnimation.value.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 39,
                  color: _animationController.isAnimating &&
                          (_aniDelta != null ? _aniDelta : 8000) >
                              (lpAnimation != null ? lpAnimation.value : 8000)
                      ? Colors.green
                      : (_animationController.isAnimating &&
                              (_aniDelta != null ? _aniDelta : 8000) <
                                  (lpAnimation != null
                                      ? lpAnimation.value
                                      : 8000)
                          ? Colors.red
                          : Colors.white),
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
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                String text;
                if (!(state is CalculatorMiddleUpdate) ||
                    state.props[0] == null)
                  text = '0000';
                else
                  text = state.props[0];
                return Text(
                  text,
                  style: const TextStyle(
                    fontSize: 39,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                KeyButton(KeyValues.win0),
                KeyButton(KeyValues.win1),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
