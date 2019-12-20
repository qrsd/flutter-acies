import 'package:equatable/equatable.dart';

import '../../models/game.dart';

/// Abstract of games state.
abstract class GamesState extends Equatable {
  /// Constructor
  const GamesState();

  @override
  List<Object> get props => [];
}

/// State yielded while games are being loaded.
class GamesLoading extends GamesState {}

/// State yielded after all games have been loaded.
class GamesLoaded extends GamesState {
  /// [games] is a list of all loaded games.
  final List<Game> games;

  /// Constructor
  GamesLoaded(this.games);

  @override
  List<Object> get props => [games];
}

/// State yielded if an error occurs during load.
class GamesNotLoaded extends GamesState {}
