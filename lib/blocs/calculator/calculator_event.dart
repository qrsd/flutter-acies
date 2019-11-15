import 'package:equatable/equatable.dart';

import '../../models/keys.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class CalculatorClearEvent extends CalculatorEvent {}

class CalculatorResetEvent extends CalculatorEvent {}

class CalculatorIntegerEvent extends CalculatorEvent {
  final Keys value;

  CalculatorIntegerEvent(this.value);

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'key: ${value.key}';
}

class CalculatorCalculationEvent extends CalculatorEvent {
  final Keys value;

  CalculatorCalculationEvent(this.value);

  @override
  List<Object> get props => [value];
}
