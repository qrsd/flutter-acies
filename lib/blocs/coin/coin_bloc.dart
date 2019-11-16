import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  @override
  CoinState get initialState => CoinInitial();

  @override
  Stream<CoinState> mapEventToState(
    CoinEvent event,
  ) async* {
    if (event is CoinFlipEvent) {
      yield* _mapCoinFlipEventToState();
    } else if (event is CoinResetEvent) {
      yield* _mapCoinResetEventToState();
    }
  }

  Stream<CoinState> _mapCoinFlipEventToState() async* {
    final int flip = Random().nextInt(2) + 1;
    if (state == CoinFlipped(flip)) {
      yield CoinDoubleFlipped(flip);
    } else {
      yield CoinFlipped(flip);
    }
  }

  Stream<CoinState> _mapCoinResetEventToState() async* {
    yield CoinInitial();
  }
}
