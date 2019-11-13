import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import './blocs/blocs.dart';
import './blocs/simple_bloc_delegate.dart';
import './screens/calculator_screen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CalculatorBloc>(
          builder: (context) => CalculatorBloc(),
        ),
        BlocProvider<SwipeBarBloc>(
          builder: (context) => SwipeBarBloc(),
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
      home: CalculatorPage(),
    );
  }
}
