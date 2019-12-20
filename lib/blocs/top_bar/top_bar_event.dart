import 'package:equatable/equatable.dart';

import '../../models/keys.dart';

/// Abstract of top bar events.
abstract class TopBarEvent extends Equatable {
  /// Constructor
  const TopBarEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when top bar needs to reset.
class TopBarResetEvent extends TopBarEvent {}

/// Event fires when a score action is fired.
class TopBarScoreEvent extends TopBarEvent {
  /// [value] represents the key button pressed for player that won.
  final Keys value;

  /// Constructor
  const TopBarScoreEvent(this.value);

  @override
  List<Keys> get props => [value];
}
