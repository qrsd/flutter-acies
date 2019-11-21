import 'package:equatable/equatable.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {
  final int page = 1;

  @override
  List<Object> get props => [page];
}

class HistoryPage extends HistoryState {
  final int page;
  final List<String> history;

  HistoryPage(this.page, this.history);

  @override
  List<Object> get props => [page, history];
}

class HistoryShow extends HistoryState {
  final List<String> history;

  HistoryShow(this.history);

  @override
  List<Object> get props => [history];
}

class HistoryUpdated extends HistoryState {}

class HistoryWin extends HistoryState {
  final int game;

  HistoryWin(this.game);

  @override
  List<Object> get props => [game];
}
