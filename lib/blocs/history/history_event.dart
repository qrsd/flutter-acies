import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistoryLPEvent extends HistoryEvent {
  final int player;
  final String delta;
  final bool add;

  HistoryLPEvent(this.player, this.delta, this.add);

  @override
  List<Object> get props => [player, delta, add];
}

class HistoryWinEvent extends HistoryEvent {
  final int player;

  HistoryWinEvent(this.player);

  @override
  List<Object> get props => [player];
}

class HistoryDiceEvent extends HistoryEvent {
  final int rolled;

  HistoryDiceEvent(this.rolled);

  @override
  List<Object> get props => [rolled];
}

class HistoryCoinEvent extends HistoryEvent {
  final int flipped;

  HistoryCoinEvent(this.flipped);

  @override
  List<Object> get props => [flipped];
}

class HistoryPageEvent extends HistoryEvent {
  final int page;

  HistoryPageEvent(this.page);

  @override
  List<Object> get props => [page];
}

class HistoryResetEvent extends HistoryEvent {}

class HistoryMatchOverEvent extends HistoryEvent {}
