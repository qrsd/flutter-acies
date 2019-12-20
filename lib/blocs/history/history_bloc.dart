import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../utils/constants.dart';
import '../blocs.dart';
import './bloc.dart';

/// History BLoC
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  /// [calculatorBloc] subscription to fire an event when a life point event fires.
  final CalculatorBloc calculatorBloc;

  /// [coinBloc] subscription to fire an event when a coin has been flipped.
  final CoinBloc coinBloc;

  /// [diceBloc] subscription to fire an event when dice have been rolled.
  final DieBloc diceBloc;

  /// [topBarBloc] subscription to fire an event when a game win fires.
  final TopBarBloc topBarBloc;

  int _game;
  List<String> _events;
  Map<int, dynamic> _history;
  String _playerOne;
  String _playerTwo;
  int _playerOneScore;
  int _playerTwoScore;

  StreamSubscription _calculatorSubscription;
  StreamSubscription _coinSubscription;
  StreamSubscription _diceSubscription;
  StreamSubscription _topBarSubscription;

  /// Constructor
  HistoryBloc(
      {@required this.calculatorBloc,
      @required this.topBarBloc,
      @required this.diceBloc,
      @required this.coinBloc}) {
    _game = 0;
    _events = [];
    _history = <int, dynamic>{};
    _playerOne = 'You';
    _playerTwo = 'Opponent';
    _playerOneScore = 0;
    _playerTwoScore = 0;
    _calculatorSubscription = calculatorBloc.listen((state) {
      if (state is CalculatorP1LPUpdate) {
        add(HistoryLPEvent(0, state.delta, add: state.add));
      } else if (state is CalculatorP2LPUpdate) {
        add(HistoryLPEvent(1, state.delta, add: state.add));
      }
    });
    _coinSubscription = coinBloc.listen((state) {
      if (state is CoinFlipped || state is CoinDoubleFlipped) {
        add(HistoryCoinEvent(state.props[0]));
      }
    });
    _diceSubscription = diceBloc.listen((state) {
      if (state is DieRolled || state is DieDoubleRolled) {
        add(HistoryDiceEvent(state.props[0]));
      }
    });
    _topBarSubscription = topBarBloc.listen((state) {
      if (state is TopBarP1Win) {
        add(HistoryWinEvent(playerOneVal));
      } else if (state is TopBarP2Win) {
        add(HistoryWinEvent(playerTwoVal));
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
    } else if (event is HistoryShowEvent) {
      yield* _mapHistoryShowEventToState();
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
    _events.add(coinUpdate);
    _history[_game] = _events;
    yield HistoryUpdated();
  }

  Stream<HistoryState> _mapHistoryDiceEventToState(
      HistoryDiceEvent event) async* {
    String dieUpdate;
    dieUpdate = 'Die ${event.rolled}';
    _events.add(dieUpdate);
    _history[_game] = _events;
    yield HistoryUpdated();
  }

  Stream<HistoryState> _mapHistoryLPEventToState(HistoryLPEvent event) async* {
    String lpUpdate;
    lpUpdate = event.player == playerOneVal ? '$_playerOne' : '$_playerTwo';
    lpUpdate = event.add
        ? '$lpUpdate +${event.delta.toString()}'
        : '$lpUpdate -${event.delta.toString()}';
    _events.add(lpUpdate);
    _history[_game] = _events;
    yield HistoryUpdated();
  }

  Stream<HistoryState> _mapHistoryMatchOverEventToState() async* {
    yield HistorySaving(
        _playerOne, _playerTwo, _playerOneScore, _playerTwoScore, _history);
  }

  Stream<HistoryState> _mapHistoryNameChangeEventToState(
      HistoryNameChangeEvent event) async* {
    if (event.player == playerOneVal) {
      _playerOne = event.name;
    } else {
      _playerTwo = event.name;
    }
    yield HistoryUpdated();
  }

  Stream<HistoryState> _mapHistoryPageEventToState(
      HistoryPageEvent event) async* {
    yield HistoryPage(event.page, _history[event.page]);
  }

  Stream<HistoryState> _mapHistoryShowEventToState() async* {
    yield HistoryPage(_game, _history[_game]);
  }

  Stream<HistoryState> _mapHistoryResetEventToState() async* {
    _game = 0;
    _events = [];
    _history = <int, dynamic>{};
    _playerOneScore = 0;
    _playerTwoScore = 0;
    yield HistoryInitial();
  }

  Stream<HistoryState> _mapHistoryWinEventToState(
      HistoryWinEvent event) async* {
    String winUpdate;
    if (event.player == playerOneVal) {
      winUpdate = '$_playerOne Won';
      ++_playerOneScore;
    } else {
      winUpdate = '$_playerTwo Won';
      ++_playerTwoScore;
    }
    _events.add(winUpdate);
    _history[_game] = _events;
    _events = [];
    _game = _game >= 2 ? 2 : ++_game;
    yield HistoryWin(_game);
  }

  @override
  Future<void> close() {
    _calculatorSubscription.cancel();
    _coinSubscription.cancel();
    _diceSubscription.cancel();
    _topBarSubscription.cancel();
    return super.close();
  }
}
