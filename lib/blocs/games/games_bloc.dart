import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../blocs.dart';
import '../../models/models.dart';
import '../../repository/game_repository_local.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GameRepositoryLocal gameRepositoryLocal;
  final HistoryBloc historyBloc;
  final NotesBloc notesBloc;

  int id;
  String playerOne;
  String playerTwo;
  int playerOneScore;
  int playerTwoScore;
  Map<String, dynamic> notes;
  Map<int, dynamic> history;

  StreamSubscription historySubscription;
  StreamSubscription notesSubscription;

  GamesBloc(
      {@required this.historyBloc,
      @required this.notesBloc,
      @required this.gameRepositoryLocal}) {
    historySubscription = historyBloc.listen((state) {
      if (state is HistorySaving) {
        add(GamesHistoryEvent(state.playerOne, state.playerTwo,
            state.playerOneScore, state.playerTwoScore, state.history));
      }
    });
    notesSubscription = notesBloc.listen((state) {
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
    if (event is GamesLoadEvent) {
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
        List<Game> g;
        yield GamesLoaded(g);
      } else {
        yield GamesLoaded(games.map(Game.fromEntity).toList());
      }
    } catch (e) {
//      print('games bloc error');
      yield GamesNotLoaded();
    }
  }

  Stream<GamesState> _addGame() async* {
    if (state is GamesLoaded) {
      var loadedGames = (state as GamesLoaded).games;
      final List<Game> gameList =
          loadedGames == null ? [] : List.from(loadedGames);
      final Game newGame = Game(
          id: gameList.length,
          playerOne: this.playerOne,
          playerTwo: this.playerTwo,
          playerOneScore: this.playerOneScore,
          playerTwoScore: this.playerTwoScore,
          date: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          notes: this.notes,
          history: this.history);
      final List<Game> updatedGames = gameList..add(newGame);
      yield GamesLoaded(updatedGames);
      _saveGames(updatedGames);
    }
  }

  Stream<GamesState> _mapGameHistoryEventToState(
      GamesHistoryEvent event) async* {
    playerOne = event.playerOne ?? 'You';
    playerTwo = event.playerTwo ?? 'Opponent';
    playerOneScore = event.playerOneScore;
    playerTwoScore = event.playerTwoScore;
    history = event.history;
    await Future.delayed(Duration(seconds: 2));
    yield* _addGame();
//    print(
//        'p1:${event.playerOne} p2:${event.playerTwo} p1s:${event.playerOneScore} p2s:${event.playerTwoScore} h:${event.history}');
  }

  Stream<GamesState> _mapGameNotesEventToState(GamesNotesEvent event) async* {
    notes = event.notes ?? ' ';
//
//    print('${event.notes}');
  }

  Future _saveGames(List<Game> games) {
    return gameRepositoryLocal
        .saveGames(games.map((game) => game.toEntity()).toList());
  }

  @override
  Future<void> close() {
    historySubscription.cancel();
    notesSubscription.cancel();
    return super.close();
  }
}
