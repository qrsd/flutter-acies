import 'package:meta/meta.dart';

import './game_repository.dart';
import '../utils/file_storage.dart';
import '../entities/game_entity.dart';

class GameRepositoryLocal implements GameRepository {
  final FileStorage fileStorage;

  const GameRepositoryLocal({@required this.fileStorage});

  @override
  Future saveGames(List<GameEntity> games) {
    return fileStorage.saveGames(games);
  }

  @override
  Future<List<GameEntity>> loadGames() async {
    try {
      return await fileStorage.loadGames();
    } catch (_) {
      return null;
    }
  }
}
