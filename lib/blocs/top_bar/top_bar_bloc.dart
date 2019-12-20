import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

/// Top bar BLoC.
class TopBarBloc extends Bloc<TopBarEvent, TopBarState> {
  static int _p1Score;
  static int _p2Score;
  bool _gameOver;

  /// Constructor
  TopBarBloc() {
    _p1Score = 0;
    _p2Score = 0;
    _gameOver = false;
  }

  @override
  TopBarState get initialState => TopBarInitial();

  @override
  Stream<TopBarState> mapEventToState(
    TopBarEvent event,
  ) async* {
    if (event is TopBarResetEvent) {
      yield* _mapTopBarResetEventToState();
    } else if (event is TopBarScoreEvent) {
      yield* _mapTopBarScoreEventToState(event);
    }
  }

  Stream<TopBarState> _mapTopBarResetEventToState() async* {
    _p1Score = 0;
    _p2Score = 0;
    _gameOver = false;
    yield TopBarInitial();
  }

  Stream<TopBarState> _mapTopBarScoreEventToState(
      TopBarScoreEvent event) async* {
    var val = event.value.key;
    if (!_gameOver) {
      if (val.contains('0')) {
        ++_p1Score;
        yield TopBarP1Win(_p1Score);
        if (_p1Score == 2) {
          _gameOver = true;
          yield TopBarMatchOver();
        }
      } else {
        ++_p2Score;
        yield TopBarP2Win(_p2Score);
        if (_p2Score == 2) {
          _gameOver = true;
          yield TopBarMatchOver();
        }
      }
    }
  }
}
