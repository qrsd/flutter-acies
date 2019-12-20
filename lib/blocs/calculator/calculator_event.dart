import 'package:equatable/equatable.dart';

import '../../models/keys.dart';

/// Abstract of calculator events.
abstract class CalculatorEvent extends Equatable {
  /// Constructor
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when a life points are gained or lost.
class CalculatorCalculationEvent extends CalculatorEvent {
  /// [value] of calculation event firing.
  final Keys value;

  /// Constructor
  CalculatorCalculationEvent(this.value);

  @override
  List<Object> get props => [value];
}

/// Event fires when center/delta needs to be cleared.
class CalculatorClearEvent extends CalculatorEvent {}

/// Event fires when an integer button is pressed.
class CalculatorIntegerEvent extends CalculatorEvent {
  /// [value] of integer.
  final Keys value;

  /// Constructor
  CalculatorIntegerEvent(this.value);

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'key: ${value.key}';
}

/// Event fires when the calculator needs to be reset.
class CalculatorResetEvent extends CalculatorEvent {}

//class CalculatorResumeEevent extends CalculatorEvent {
//  final int player;
//
//  CalculatorResumeEvent(this.player);
//
//  @override
//  List<Object> get props => [player];
//}
