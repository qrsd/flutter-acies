import 'package:equatable/equatable.dart';

import '../../models/keys.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();
}

class IntegerEvent extends CalculatorEvent {
  final Keys value;

  IntegerEvent(this.value);

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'key: ${value.key}';
}

class ClearEvent extends CalculatorEvent {
  @override
  List<Object> get props => [];
}

class CalculationEvent extends CalculatorEvent {
  final Keys value;

  CalculationEvent(this.value);

  @override
  List<Object> get props => [value];
}
