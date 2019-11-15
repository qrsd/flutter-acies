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
    if (event is TopBarScoreEvent) {
      yield* _mapTopBarScoreEventToState(event);
    } else if (event is TopBarResetEvent) {
      yield* _mapTopBarResetEventToState();
    } else if (event is TopBarNotesEvent) {
      yield* _mapTopBarNotesEventToState();
    } else if (event is TopBarBackEvent) {
      yield* _mapTopBarBackEventToState();
    }
  }

  Stream<TopBarState> _mapTopBarScoreEventToState(
      TopBarScoreEvent event) async* {
    String val = event.value.key;
    if (val.contains('0')) {
      _p1Score = _p1Score >= 2 ? 2 : ++_p1Score;
      yield TopBarP1Win(_p1Score);
    } else {
      _p2Score = _p2Score >= 2 ? 2 : ++_p2Score;
      yield TopBarP2Win(_p2Score);
    }
  }

  Stream<TopBarState> _mapTopBarResetEventToState() async* {
    _p1Score = 0;
    _p2Score = 0;
    yield TopBarInitial();
  }

  Stream<TopBarState> _mapTopBarNotesEventToState() async* {
    yield TopBarNotes();
  }

  Stream<TopBarState> _mapTopBarBackEventToState() async* {
    yield TopBarBack();
  }
}
