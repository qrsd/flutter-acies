import 'package:equatable/equatable.dart';

/// Abstract of coin state.
abstract class CoinState extends Equatable {
  /// Constructor
  const CoinState();

  @override
  List<Object> get props => [];
}

/// Initial coin state
class CoinInitial extends CoinState {
  /// [initialFlip] of coin.
  final int initialFlip = 0;

  @override
  List<Object> get props => [initialFlip];
}

/// State yielded when coin flip is a double.
class CoinDoubleFlipped extends CoinState {
  /// [flipValue] of coin.
  final int flipValue;

  /// Constructor
  CoinDoubleFlipped(this.flipValue);

  @override
  List<Object> get props => [flipValue];
}

/// State yielded when coin is flipped.
class CoinFlipped extends CoinState {
  /// [flipValue] of coin.
  final int flipValue;

  /// Constructor
  CoinFlipped(this.flipValue);

  @override
  List<Object> get props => [flipValue];
}
