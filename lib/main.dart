import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import './blocs/blocs.dart';
import './blocs/simple_bloc_delegate.dart';
import './repository/repositories.dart';
import './screens/screens.dart';
import './utils/constants.dart';
import './utils/file_storage.dart';
import './utils/ticker.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CoinBloc>(
          create: (context) => CoinBloc(),
        ),
        BlocProvider<DieBloc>(
          create: (context) => DieBloc(),
        ),
        BlocProvider<SwipeBarBloc>(
          create: (context) => SwipeBarBloc(),
        ),
        BlocProvider<TopBarBloc>(
          create: (context) => TopBarBloc(),
        ),
        BlocProvider<NotesBloc>(
          create: (context) => NotesBloc(),
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
            diceBloc: BlocProvider.of<DieBloc>(context),
          ),
        ),
        BlocProvider<GamesBloc>(
          create: (context) => GamesBloc(
            notesBloc: BlocProvider.of<NotesBloc>(context),
            historyBloc: BlocProvider.of<HistoryBloc>(context),
            gameRepositoryLocal: const GameRepositoryLocal(
                fileStorage: FileStorage(
                    '__games_storage__', getApplicationDocumentsDirectory)),
          )..add(GamesLoadEvent()),
        ),
      ],
      child: CalculatorApp(),
    ),
  );
}

/// Setups app
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: CalculatorScreen(),
    );
  }
}
