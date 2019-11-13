import 'package:equatable/equatable.dart';

import '../../models/keys.dart';

abstract class TopBarEvent extends Equatable {
  const TopBarEvent();
}

class ScoreUpdate extends TopBarEvent {
  final Keys value;

  const ScoreUpdate(this.value);

  @override
  List<Keys> get props => [value];
}
