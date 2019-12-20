import 'dart:async';

import '../entities/entities.dart';

/// Abstract representation of the game repository.
abstract class GameRepository {
  /// Function must be overridden when implemented.
  Future<List<GameEntity>> loadGames();

  /// Function must be overridden when implemented.
  Future saveGames(List<GameEntity> games);
}
