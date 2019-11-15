import 'package:equatable/equatable.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorClear extends CalculatorState {}

class CalculatorMiddleUpdate extends CalculatorState {
  final String delta;

  CalculatorMiddleUpdate(this.delta);

  @override
  List<String> get props => [delta];
}

class CalculatorP1LPUpdate extends CalculatorState {
  final int p1LP;

  CalculatorP1LPUpdate(this.p1LP);

  @override
  List<int> get props => [p1LP];
}

class CalculatorP2LPUpdate extends CalculatorState {
  final int p2LP;

  CalculatorP2LPUpdate(this.p2LP);

  @override
  List<int> get props => [p2LP];
}
