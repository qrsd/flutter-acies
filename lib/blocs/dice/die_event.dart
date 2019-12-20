import 'package:equatable/equatable.dart';

/// Abstract of die events.
abstract class DieEvent extends Equatable {
  /// Constructor
  const DieEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when the die needs to be reset.
class DieResetEvent extends DieEvent {}

/// Event fires when die is rolled.
class DieRollEvent extends DieEvent {}
