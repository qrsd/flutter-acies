import 'package:equatable/equatable.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class MiddleUpdate extends CalculatorState {
  final String delta;

  MiddleUpdate(this.delta);

  @override
  List<String> get props => [delta];
}

class P1LPUpdate extends CalculatorState {
  final int p1LP;

  P1LPUpdate(this.p1LP);

  @override
  List<int> get props => [p1LP];
}

class P2LPUpdate extends CalculatorState {
  final int p2LP;

  P2LPUpdate(this.p2LP);

  @override
  List<int> get props => [p2LP];
}
