import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';

import './bloc.dart';

/// Die BLoC
class DieBloc extends Bloc<DieEvent, DieState> {
  @override
  DieState get initialState => DieInitial();

  @override
  Stream<DieState> mapEventToState(
    DieEvent event,
  ) async* {
    if (event is DieResetEvent) {
      yield* _mapDieResetEventToState();
    } else if (event is DieRollEvent) {
      yield* _mapDieRolledEventToState();
    }
  }

  Stream<DieState> _mapDieResetEventToState() async* {
    yield DieInitial();
  }

  Stream<DieState> _mapDieRolledEventToState() async* {
    final roll = Random().nextInt(6) + 1;
    if (state == DieRolled(roll)) {
      yield DieDoubleRolled(roll);
    } else {
      yield DieRolled(roll);
    }
  }
}
