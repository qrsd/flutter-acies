import 'package:equatable/equatable.dart';

abstract class TopBarEvent extends Equatable {
  const TopBarEvent();
}

class ScoreUpdate extends TopBarEvent {
  final int player;

  const ScoreUpdate(this.player);

  @override
  List<Object> get props => [player];
}
