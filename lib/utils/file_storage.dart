import 'dart:convert';
import 'dart:io';

import '../entities/entities.dart';

// ignore_for_file: unnecessary_lambdas
/// Class used to store game history on device.
class FileStorage {
  /// [fileName] of file used to save games.
  final String fileName;

  /// [getDirectory] of flutter default app location.
  final Future<Directory> Function() getDirectory;

  /// Constructor
  const FileStorage(
    this.fileName,
    this.getDirectory,
  );

  /// Loads games from [fileName] at [getDirectory].
  Future<List<GameEntity>> loadGames() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final games = (json['games'])
        .map<GameEntity>((game) => GameEntity.fromJson(game))
        .toList();
    return games;
  }

  /// Loads games from [fileName] at [getDirectory].
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

  /// Deletes previous file.
  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
