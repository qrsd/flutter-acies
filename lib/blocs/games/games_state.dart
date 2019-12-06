import 'package:equatable/equatable.dart';

import '../../models/game.dart';

abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object> get props => [];
}

class GamesLoading extends GamesState {}

class GamesLoaded extends GamesState {
  final List<Game> games;

  GamesLoaded(this.games);

  @override
  List<Object> get props => [games];
}

class GamesNotLoaded extends GamesState {}
