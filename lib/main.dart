import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/blocs.dart';
import './blocs/simple_bloc_delegate.dart';
import './screens/calculator_screen.dart';
import './utils/animated_splash_custom.dart';
import './utils/constants.dart';
import './utils/ticker.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AdsBloc>(
          create: (context) => AdsBloc(),
        ),
        BlocProvider<CoinBloc>(
          create: (context) => CoinBloc(),
        ),
        BlocProvider<DiceBloc>(
          create: (context) => DiceBloc(),
        ),
        BlocProvider<NotesBloc>(
          create: (context) => NotesBloc(),
        ),
        BlocProvider<SwipeBarBloc>(
          create: (context) => SwipeBarBloc(),
        ),
        BlocProvider<TopBarBloc>(
          create: (context) => TopBarBloc(),
        ),
        BlocProvider<TimerBloc>(
          create: (context) => TimerBloc(
            ticker: Ticker(),
            topBarBloc: BlocProvider.of<TopBarBloc>(context),
          ),
        ),
        BlocProvider<CalculatorBloc>(
          create: (context) => CalculatorBloc(
            topBarBloc: BlocProvider.of<TopBarBloc>(context),
          ),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => HistoryBloc(
            calculatorBloc: BlocProvider.of<CalculatorBloc>(context),
            topBarBloc: BlocProvider.of<TopBarBloc>(context),
            coinBloc: BlocProvider.of<CoinBloc>(context),
            diceBloc: BlocProvider.of<DiceBloc>(context),
          ),
        ),
      ],
      child: CalculatorApp(),
    ),
  );
}

class CalculatorApp extends StatelessWidget {
  Future<Widget> customFunction(context) {
    BlocProvider.of<AdsBloc>(context).add(AdsShowEvent());
    return Future.value(CalculatorPage());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: AnimatedSplash.styled(
        imagePath: 'assets/splash.png',
        customFunction: customFunction(context),
        backgroundColor: primaryColor,
        duration: 3500,
        style: AnimationStyle.Still,
        curve: Curves.linear,
      ),
    );
  }
}
