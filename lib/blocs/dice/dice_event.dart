import 'package:equatable/equatable.dart';

abstract class DiceEvent extends Equatable {
  const DiceEvent();

  @override
  List<Object> get props => [];
}

class DiceRollEvent extends DiceEvent {}

class DiceResetEvent extends DiceEvent {}
