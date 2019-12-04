import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../utils/constants.dart';
import './bloc.dart';
import '../blocs.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final CalculatorBloc calculatorBloc;
  final CoinBloc coinBloc;
  final DiceBloc diceBloc;
  final TopBarBloc topBarBloc;

  bool matchOver;
  int game;
  List<String> events;
  Map<int, dynamic> history;
  String player1;
  String player2;

  StreamSubscription calculatorSubscription;
  StreamSubscription coinSubscription;
  StreamSubscription diceSubscription;
  StreamSubscription topBarSubscription;

  HistoryBloc(
      {@required this.calculatorBloc,
      @required this.topBarBloc,
      @required this.diceBloc,
      @required this.coinBloc}) {
    matchOver = false;
    game = 0;
    events = [];
    history = <int, dynamic>{};
    player1 = 'You';
    player2 = 'Opponent';
    calculatorSubscription = calculatorBloc.listen((state) {
      if (state is CalculatorP1LPUpdate) {
        add(HistoryLPEvent(0, state.delta, state.add));
      } else if (state is CalculatorP2LPUpdate) {
        add(HistoryLPEvent(1, state.delta, state.add));
      }
    });
    coinSubscription = coinBloc.listen((state) {
      if (state is CoinFlipped || state is CoinDoubleFlipped) {
        add(HistoryCoinEvent(state.props[0]));
      }
    });
    diceSubscription = diceBloc.listen((state) {
      if (state is DiceRolled || state is DiceDoubleRolled) {
        add(HistoryDiceEvent(state.props[0]));
      }
    });
    topBarSubscription = topBarBloc.listen((state) {
      if (state is TopBarP1Win) {
        add(HistoryWinEvent(0));
      } else if (state is TopBarP2Win) {
        add(HistoryWinEvent(1));
      } else if (state is TopBarMatchOver) {
        add(HistoryMatchOverEvent());
      }
    });
  }

  @override
  HistoryState get initialState => HistoryInitial();

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is HistoryCoinEvent) {
      yield* _mapHistoryCoinEventToState(event);
    } else if (event is HistoryDiceEvent) {
      yield* _mapHistoryDiceEventToState(event);
    } else if (event is HistoryLPEvent) {
      yield* _mapHistoryLPEventToState(event);
    } else if (event is HistoryMatchOverEvent) {
      yield* _mapHistoryMatchOverEventToState();
    } else if (event is HistoryNameChangeEvent) {
      yield* _mapHistoryNameChangeEventToState(event);
    } else if (event is HistoryPageEvent) {
      yield* _mapHistoryPageEventToState(event);
    } else if (event is HistoryPressedEvent) {
      yield* _mapHistoryPressedEventToState();
    } else if (event is HistoryResetEvent) {
      yield* _mapHistoryResetEventToState();
    } else if (event is HistoryWinEvent) {
      yield* _mapHistoryWinEventToState(event);
    }
  }

  Stream<HistoryState> _mapHistoryCoinEventToState(
      HistoryCoinEvent event) async* {
    String coinUpdate;
    coinUpdate = event.flipped == 1 ? 'Coin Heads' : 'Coin Tails';
    events.add(coinUpdate);
    history[game] = events;
    yield HistoryUpdated();
  }

  Stream<HistoryState> _mapHistoryDiceEventToState(
      HistoryDiceEvent event) async* {
    String dieUpdate;
    dieUpdate = 'Die ${event.rolled}';
    events.add(dieUpdate);
    history[game] = events;
    yield HistoryUpdated();
  }

  Stream<HistoryState> _mapHistoryLPEventToState(HistoryLPEvent event) async* {
    String lpUpdate;
    lpUpdate = event.player == playerOne ? '$player1' : '$player2';
    lpUpdate = event.add
        ? '$lpUpdate +${event.delta.toString()}'
        : '$lpUpdate -${event.delta.toString()}';
    events.add(lpUpdate);
    history[game] = events;
    yield HistoryUpdated();
  }

  Stream<HistoryState> _mapHistoryMatchOverEventToState() async* {
    matchOver = true;
    yield HistoryUpdated();
  }

  Stream<HistoryState> _mapHistoryNameChangeEventToState(
      HistoryNameChangeEvent event) async* {
    if (event.player == playerOne) {
      player1 = event.name;
    } else {
      player2 = event.name;
    }
    yield HistoryUpdated();
  }

  Stream<HistoryState> _mapHistoryPageEventToState(
      HistoryPageEvent event) async* {
    yield HistoryPage(event.page, history[event.page]);
  }

  Stream<HistoryState> _mapHistoryPressedEventToState() async* {
    yield HistoryPage(game, history[game]);
  }

  Stream<HistoryState> _mapHistoryResetEventToState() async* {
    matchOver = false;
    game = 0;
    events = [];
    history = <int, dynamic>{};
    yield HistoryInitial();
  }

  Stream<HistoryState> _mapHistoryWinEventToState(
      HistoryWinEvent event) async* {
    String winUpdate;
    winUpdate = event.player == playerOne ? '$player1 Won' : '$player2 Won';
    events.add(winUpdate);
    history[game] = events;
    events = [];
    if (!matchOver) {
      ++game;
    }
    yield HistoryWin(game);
  }

  @override
  Future<void> close() {
    calculatorSubscription.cancel();
    coinSubscription.cancel();
    diceSubscription.cancel();
    topBarSubscription.cancel();
    return super.close();
  }
}
