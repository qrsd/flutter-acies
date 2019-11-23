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
  final String delta;
  final bool add;

  CalculatorP1LPUpdate(this.p1LP, this.delta, this.add);

  @override
  List<Object> get props => [p1LP, delta, add];
}

class CalculatorP2LPUpdate extends CalculatorState {
  final int p2LP;
  final String delta;
  final bool add;

  CalculatorP2LPUpdate(this.p2LP, this.delta, this.add);

  @override
  List<Object> get props => [p2LP, delta, add];
}

class CalculatorResume extends CalculatorState {
  final int player;
  final int resumeLP;

  CalculatorResume(this.player, this.resumeLP);

  @override
  List<Object> get props => [player, resumeLP];
}
