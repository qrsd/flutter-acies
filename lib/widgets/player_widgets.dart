import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';
import '../utils/controller.dart';
import '../widgets/keys.dart';

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
        initialValue: this.player == PLAYER_1 ? 'You' : 'Opponent',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF947FFD),
            ),
          ),
        ),
        onFieldSubmitted: (test) {
          SystemChrome.restoreSystemUIOverlays();
        },
      ),
    );
  }
}

class LifePoints extends StatefulWidget {
  final int player;
  static _LifePointsState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LifePointsState>());
  LifePoints(this.player);

  @override
  _LifePointsState createState() => _LifePointsState();
}

class _LifePointsState extends State<LifePoints>
    with SingleTickerProviderStateMixin {
  static const int animationDuration = 2000;
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
    return StreamBuilder(
      stream: widget.player == PLAYER_1 ? Brain.p1Stream : Brain.p2Stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _aniDelta = snapshot.data;
          _tween.begin = _tween.end;
          _tween.end = _aniDelta;
          _animationController.forward(from: 0);
        }
        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            return Text(lpAnimation.value.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
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
  final String _delta;

  CenterColumn(this._delta);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              _delta ?? '0000',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                KeyButton(KeyValues.win0),
                KeyButton(KeyValues.win1),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          Icons.clear,
          color: Colors.white,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.radio_button_unchecked,
                color: Colors.white,
              ),
              Icon(
                Icons.radio_button_unchecked,
                color: Colors.white,
              ),
              Text(
                'Timer',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.radio_button_unchecked,
                color: Colors.white,
              ),
              Icon(
                Icons.check_circle_outline,
                color: Color(0xFF947FFD),
              ),
            ],
          ),
        ),
        Text(
          'Notes',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
