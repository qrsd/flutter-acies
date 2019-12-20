import 'package:equatable/equatable.dart';

/// Abstract of history state.
abstract class HistoryState extends Equatable {
  /// Constructor
  const HistoryState();

  @override
  List<Object> get props => [];
}

/// Initial history state
class HistoryInitial extends HistoryState {
  /// [page] to be displayed.
  final int page = 1;

  @override
  List<Object> get props => [page];
}

/// State yielded when history widget is to be displayed. Yields current game
/// and its history.
class HistoryPage extends HistoryState {
  /// [page] to be displayed.
  final int page;

  /// [history] of this [page].
  final List<String> history;

  /// Constructor
  HistoryPage(this.page, this.history);

  @override
  List<Object> get props => [page, history];
}

/// State yielded when history is going to be saved to file after a match ends.
class HistorySaving extends HistoryState {
  /// [playerOne] name.
  final String playerOne;

  /// [playerTwo] name.
  final String playerTwo;

  /// [playerOneScore] of this game.
  final int playerOneScore;

  /// [playerTwoScore] of this game.
  final int playerTwoScore;

  /// [history] contains all events of this game.
  final Map<int, dynamic> history;

  /// Constructor
  HistorySaving(this.playerOne, this.playerTwo, this.playerOneScore,
      this.playerTwoScore, this.history);

  @override
  List<Object> get props =>
      [playerOne, playerTwo, playerOneScore, playerTwoScore, history];
}

/// State yielded when an event fires and it is to be added to history.
class HistoryUpdated extends HistoryState {}

/// State yielded when a game is won.
class HistoryWin extends HistoryState {
  /// [game] is the new game.
  final int game;

  /// Constructor
  HistoryWin(this.game);

  @override
  List<Object> get props => [game];
}
