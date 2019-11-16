import 'package:equatable/equatable.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();

  @override
  List<Object> get props => [];
}

class CoinFlipEvent extends CoinEvent {}

class CoinResetEvent extends CoinEvent {}
