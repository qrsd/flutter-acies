import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../models/models.dart';
import '../../repository/game_repository_local.dart';
import '../blocs.dart';
import './bloc.dart';

/// Games BLoC
class GamesBloc extends Bloc<GamesEvent, GamesState> {
  /// [gameRepositoryLocal] provides the data layer.
  final GameRepositoryLocal gameRepositoryLocal;

  /// [historyBloc] subscription to fire event after collecting history.
  final HistoryBloc historyBloc;

  /// [notesBloc] subscription to fire event after collecting notes.
  final NotesBloc notesBloc;

  bool _gameOver;
  int _playerOneScore;
  int _playerTwoScore;
  String _playerOne;
  String _playerTwo;
  Map<String, dynamic> _notes;
  Map<int, dynamic> _history;
  var _uuid;

  StreamSubscription _historySubscription;
  StreamSubscription _notesSubscription;

  /// Constructor
  GamesBloc(
      {@required this.historyBloc,
      @required this.notesBloc,
      @required this.gameRepositoryLocal}) {
    _gameOver = false;
    _uuid = Uuid();
    _historySubscription = historyBloc.listen((state) {
      if (state is HistorySaving) {
        add(GamesHistoryEvent(state.playerOne, state.playerTwo,
            state.playerOneScore, state.playerTwoScore, state.history));
      }
    });
    _notesSubscription = notesBloc.listen((state) {
      if (state is NotesSaving) {
        add(GamesNotesEvent(state.notes));
      }
    });
  }

  @override
  GamesState get initialState => GamesLoading();

  @override
  Stream<GamesState> mapEventToState(
    GamesEvent event,
  ) async* {
    if (event is GamesAddEvent) {
      yield* _mapGameAddEventToState(event: event);
    } else if (event is GamesDeleteEvent) {
      yield* _mapGameDeleteEventToState(event);
    } else if (event is GamesLoadEvent) {
      yield* _mapGameLoadEventToState();
    } else if (event is GamesHistoryEvent) {
      yield* _mapGameHistoryEventToState(event);
    } else if (event is GamesNotesEvent) {
      yield* _mapGameNotesEventToState(event);
    }
  }

  Stream<GamesState> _mapGameLoadEventToState() async* {
    try {
      final games = await gameRepositoryLocal.loadGames();
      if (games == null) {
        List<Game> emptyGamesList;
        yield GamesLoaded(emptyGamesList);
      } else {
        yield GamesLoaded(games.map(Game.fromEntity).toList());
      }
    } on Exception catch (e) {
      print(e);
      yield GamesNotLoaded();
    }
  }

  Stream<GamesState> _mapGameAddEventToState({GamesAddEvent event}) async* {
    if (state is GamesLoaded) {
      var loadedGames = (state as GamesLoaded).games;
      final gameList = loadedGames == null ? [] : List.from(loadedGames);
      final newGame = event == null
          ? Game(
              id: _uuid.v4(),
              playerOne: _playerOne,
              playerTwo: _playerTwo,
              playerOneScore: _playerOneScore,
              playerTwoScore: _playerTwoScore,
              date: DateTime.now().millisecondsSinceEpoch ~/ 1000,
              notes: _notes,
              history: _history)
          : event.game;
      final updatedGames = (gameList..add(newGame)).cast<Game>();
      yield GamesLoaded(updatedGames);
      _saveGames(updatedGames);
    }
  }

  Stream<GamesState> _mapGameDeleteEventToState(GamesDeleteEvent event) async* {
    if (state is GamesLoaded) {
      final updatedGames = (state as GamesLoaded)
          .games
          .where((game) => game.id != event.game.id)
          .toList();
      yield GamesLoaded(updatedGames);
      _saveGames(updatedGames);
    }
  }

  Stream<GamesState> _mapGameHistoryEventToState(
      GamesHistoryEvent event) async* {
    _playerOne = event.playerOne ?? 'You';
    _playerTwo = event.playerTwo ?? 'Opponent';
    _playerOneScore = event.playerOneScore;
    _playerTwoScore = event.playerTwoScore;
    _history = event.history;
    _gameOver = true;

//    print(
//        'p1:${event.playerOne} p2:${event.playerTwo} p1s:${event.playerOneScore} p2s:${event.playerTwoScore} h:${event.history}');
  }

  Stream<GamesState> _mapGameNotesEventToState(GamesNotesEvent event) async* {
    _notes = event.notes ?? ' ';
    if (_gameOver) {
      _gameOver = false;
      yield* _mapGameAddEventToState();
    }
//
//    print('${event.notes}');
  }

  Future _saveGames(List<Game> games) {
    return gameRepositoryLocal
        .saveGames(games.map((game) => game.toEntity()).toList());
  }

  @override
  Future<void> close() {
    _historySubscription.cancel();
    _notesSubscription.cancel();
    return super.close();
  }
}
