import 'dart:async';

import '../entities/entities.dart';

abstract class GameRepository {
  Future<List<GameEntity>> loadGames();

  Future saveGames(List<GameEntity> games);
}
