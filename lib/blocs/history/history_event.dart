import 'package:equatable/equatable.dart';

/// Abstract of history events.
abstract class HistoryEvent extends Equatable {
  /// Constructor
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when either player has their life points affected.
class HistoryLPEvent extends HistoryEvent {
  /// [player] who is receiving a life point change.
  final int player;

  /// [delta] is the change in life points.
  final String delta;

  /// [add] whether they are gaining or losing life points.
  final bool add;

  /// Constructor
  HistoryLPEvent(this.player, this.delta, {this.add});

  @override
  List<Object> get props => [player, delta, add];
}

/// Event fires when a player wins a game.
class HistoryWinEvent extends HistoryEvent {
  /// [player] that won the game.
  final int player;

  /// Constructor
  HistoryWinEvent(this.player);

  @override
  List<Object> get props => [player];
}

/// Event fires when the dice widget is rolled.
class HistoryDiceEvent extends HistoryEvent {
  /// [rolled] this result.
  final int rolled;

  /// Constructor
  HistoryDiceEvent(this.rolled);

  @override
  List<Object> get props => [rolled];
}

/// Event fires when the coin widget is flipped.
class HistoryCoinEvent extends HistoryEvent {
  /// [flipped] this result.
  final int flipped;

  /// Constructor
  HistoryCoinEvent(this.flipped);

  @override
  List<Object> get props => [flipped];
}

/// Event fires when the match is over.
class HistoryMatchOverEvent extends HistoryEvent {}

/// Event fires when either players name is changed.
class HistoryNameChangeEvent extends HistoryEvent {
  /// [player] name being changed.
  final int player;

  /// [name] this [player] is being changed too.
  final String name;

  /// Constructor
  HistoryNameChangeEvent(this.player, this.name);

  @override
  List<Object> get props => [player, name];
}

/// Event fires when a cycling through game history.
class HistoryPageEvent extends HistoryEvent {
  /// [page] being displayed.
  final int page;

  /// Constructor
  HistoryPageEvent(this.page);

  @override
  List<Object> get props => [page];
}

/// Event fires when the history widget is being displayed on screen.
class HistoryShowEvent extends HistoryEvent {}

/// Event fires when history needs to be reset.
class HistoryResetEvent extends HistoryEvent {}
