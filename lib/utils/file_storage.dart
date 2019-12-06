import 'dart:convert';
import 'dart:io';

import '../entities/entities.dart';

class FileStorage {
  final String fileName;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.fileName,
    this.getDirectory,
  );

  Future<List<GameEntity>> loadGames() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final games = (json['games'])
        .map<GameEntity>((game) => GameEntity.fromJson(game))
        .toList();

    return games;
  }

  Future<File> saveGames(List<GameEntity> games) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'games': games.map((games) => games.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/$fileName.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
