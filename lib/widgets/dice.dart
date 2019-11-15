import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';

class Dice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            pageBuilder: (context, animation, __) {
              return Center(
                child: GestureDetector(
                  onTap: () =>
                      BlocProvider.of<DiceBloc>(context).add(DiceRollEvent()),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: SECONDARY_COLOR
                          .withOpacity(animation.value == 1 ? 1 : 0),
                      boxShadow: animation.value == 1
                          ? [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(3, 3),
                                blurRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                    height: MediaQuery.of(context).size.width * .5,
                    width: MediaQuery.of(context).size.width * .5,
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 'dice',
                      child: ShakeDice(),
                    ),
                  ),
                ),
              );
            },
          ),
        )
            .then(
          (_) {
            BlocProvider.of<DiceBloc>(context).add(DiceResetEvent());
          },
        );
      },
      child: Hero(
        tag: 'dice',
        child: const Image(
          image: AssetImage('assets/dice/0.png'),
          width: 30,
        ),
      ),
    );
  }
}

class ShakeDice extends StatefulWidget {
  @override
  _ShakeDiceState createState() => _ShakeDiceState();
}

class _ShakeDiceState extends State<ShakeDice>
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
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed)
              _animationController.reverse();
          });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiceBloc, DiceState>(
      builder: (context, state) {
        if (!(state is DiceInitial)) {
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
                width: 80,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
