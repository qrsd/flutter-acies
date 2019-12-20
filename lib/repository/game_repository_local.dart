import 'package:meta/meta.dart';

import '../entities/game_entity.dart';
import '../utils/file_storage.dart';
import './game_repository.dart';

/// Implementation of the game repository.
class GameRepositoryLocal implements GameRepository {
  /// [fileStorage] is the data layer used in this app.
  final FileStorage fileStorage;

  /// Constructor
  const GameRepositoryLocal({@required this.fileStorage});

  @override
  Future saveGames(List<GameEntity> games) {
    return fileStorage.saveGames(games);
  }

  @override
  Future<List<GameEntity>> loadGames() async {
    try {
      return await fileStorage.loadGames();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
