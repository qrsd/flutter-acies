import 'package:equatable/equatable.dart';

abstract class CoinState extends Equatable {
  const CoinState();

  @override
  List<Object> get props => [];
}

class CoinInitial extends CoinState {
  final int initialFlip = 0;

  @override
  List<Object> get props => [initialFlip];
}

class CoinDoubleFlipped extends CoinState {
  final int flipValue;

  CoinDoubleFlipped(this.flipValue);

  @override
  List<Object> get props => [flipValue];
}

class CoinFlipped extends CoinState {
  final int flipValue;

  CoinFlipped(this.flipValue);

  @override
  List<Object> get props => [flipValue];
}
