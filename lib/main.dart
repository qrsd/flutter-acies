import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './blocs/blocs.dart';
import './blocs/simple_bloc_delegate.dart';
import './screens/calculator_screen.dart';
import './utils/constants.dart';
import './utils/ticker.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CalculatorBloc>(
          builder: (context) => CalculatorBloc(),
        ),
        BlocProvider<CoinBloc>(
          builder: (context) => CoinBloc(),
        ),
        BlocProvider<DiceBloc>(
          builder: (context) => DiceBloc(),
        ),
        BlocProvider<SwipeBarBloc>(
          builder: (context) => SwipeBarBloc(),
        ),
        BlocProvider<TimerBloc>(
          builder: (context) => TimerBloc(ticker: Ticker()),
        ),
        BlocProvider<TopBarBloc>(
          builder: (context) => TopBarBloc(),
        ),
        BlocProvider<HistoryBloc>(
          builder: (context) => HistoryBloc(
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
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME,
      home: CalculatorPage(),
    );
  }
}
