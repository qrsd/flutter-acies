import 'package:equatable/equatable.dart';

import '../../models/keys.dart';

abstract class TopBarEvent extends Equatable {
  const TopBarEvent();
  @override
  List<Object> get props => [];
}

class TopBarScoreEvent extends TopBarEvent {
  final Keys value;

  const TopBarScoreEvent(this.value);

  @override
  List<Keys> get props => [value];
}

class TopBarResetEvent extends TopBarEvent {}

class TopBarNotesEvent extends TopBarEvent {}

class TopBarBackEvent extends TopBarEvent {}
