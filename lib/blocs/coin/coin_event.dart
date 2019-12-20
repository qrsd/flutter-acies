import 'package:equatable/equatable.dart';

/// Abstact of coin events.
abstract class CoinEvent extends Equatable {
  /// Constructor
  const CoinEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when coin is flipped.
class CoinFlipEvent extends CoinEvent {}

/// Event fires when coin needs to be reset.
class CoinResetEvent extends CoinEvent {}
