import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class DiceBloc extends Bloc<DiceEvent, DiceState> {
  @override
  DiceState get initialState => DiceInitial();

  @override
  Stream<DiceState> mapEventToState(
    DiceEvent event,
  ) async* {
    if (event is DiceRollEvent) {
      yield* _mapDiceRolledEventToState();
    } else if (event is DiceResetEvent) {
      yield* _mapDiceResetEventToState();
    }
  }

  Stream<DiceState> _mapDiceRolledEventToState() async* {
    final int roll = Random().nextInt(6) + 1;
    if (state == DiceRolled(roll)) {
      yield DiceDoubleRolled(roll);
    } else {
      yield DiceRolled(roll);
    }
  }

  Stream<DiceState> _mapDiceResetEventToState() async* {
    yield DiceInitial();
  }
}
