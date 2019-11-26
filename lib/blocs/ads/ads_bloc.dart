import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_admob/firebase_admob.dart';
import './bloc.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  final appId = 'ca-app-pub-9432106991309535~9803444422';
  final interId = 'ca-app-pub-9432106991309535/4476425117';

  InterstitialAd _ad;

  AdsBloc() {
    FirebaseAdMob.instance.initialize(appId: appId);
  }

  @override
  AdsState get initialState => AdsInitial();

  @override
  Stream<AdsState> mapEventToState(
    AdsEvent event,
  ) async* {
    if (event is AdsShowEvent) {
      yield* _mapAdShowEventToState();
    }
  }

  Stream<AdsState> _mapAdShowEventToState() async* {
    _ad?.dispose();
    _ad = createInsAd()
      ..load()
      ..show();
    yield AdsShow();
  }

  InterstitialAd createInsAd() {
    return InterstitialAd(
      adUnitId: interId,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }
}
