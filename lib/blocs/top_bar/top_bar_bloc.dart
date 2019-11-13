import 'dart:async';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class TopBarBloc extends Bloc<TopBarEvent, TopBarState> {
  static int _p1Score;
  static int _p2Score;

  TopBarBloc() {
    _p1Score = 0;
    _p2Score = 0;
  }

  @override
  TopBarState get initialState => TopBarInitial();

  @override
  Stream<TopBarState> mapEventToState(
    TopBarEvent event,
  ) async* {
    if (event is ScoreUpdate) {
      yield* _mapScoreUpdateToState(event);
    }
  }

  Stream<TopBarState> _mapScoreUpdateToState(ScoreUpdate event) async* {
    String val = event.value.key;
    if (val.contains('0')) {
      _p1Score = _p1Score >= 2 ? 2 : ++_p1Score;
      yield P1Win(_p1Score);
    } else {
      _p2Score = _p2Score >= 2 ? 2 : ++_p2Score;
      yield P2Win(_p2Score);
    }
  }
}
