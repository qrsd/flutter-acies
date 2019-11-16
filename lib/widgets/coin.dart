import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';

class Coin extends StatelessWidget {
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
                      BlocProvider.of<CoinBloc>(context).add(CoinFlipEvent()),
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
                      tag: 'coin',
                      child: FlipCoin(),
                    ),
                  ),
                ),
              );
            },
          ),
        )
            .then(
          (_) {
            BlocProvider.of<CoinBloc>(context).add(CoinResetEvent());
          },
        );
      },
      child: Hero(
        tag: 'coin',
        child: const Image(
          image: AssetImage('assets/coins/0.png'),
          width: 30,
        ),
      ),
    );
  }
}

class FlipCoin extends StatefulWidget {
  @override
  _FlipCoinState createState() => _FlipCoinState();
}

class _FlipCoinState extends State<FlipCoin>
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
    return BlocBuilder<CoinBloc, CoinState>(
      builder: (context, state) {
        print(state);
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
