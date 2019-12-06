import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../blocs.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final TopBarBloc topBarBloc;

  TextEditingController _noteController;
  TextEditingController _titleController;

  StreamSubscription topBarSubscription;

  NotesBloc({@required this.topBarBloc}) {
    _noteController = TextEditingController();
    _titleController = TextEditingController();

    topBarSubscription = topBarBloc.listen((state) {
      if (state is TopBarMatchOver) {
        add(NotesMatchOverEvent());
      }
    });
  }

  @override
  NotesState get initialState =>
      NotesInitial(this._noteController, this._titleController);

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is NotesMatchOverEvent) {
      yield* _mapNotesMatchOverEventToState();
    } else if (event is NotesResetEvent) {
      yield* _mapNotesResetEventToState();
    } else if (event is NotesShowEvent) {
      yield* _mapNotesShowEventToState();
    } else if (event is NotesUpdateEvent) {
      yield* _mapNotesUpdateEventToState(event);
    }
  }

  Stream<NotesState> _mapNotesMatchOverEventToState() async* {
    Map<String, dynamic> notes = {_titleController.text: _noteController.text};
    yield NotesSaving(notes);
  }

  Stream<NotesState> _mapNotesResetEventToState() async* {
    _noteController = TextEditingController();
    _titleController = TextEditingController();
    yield NotesReset();
  }

  Stream<NotesState> _mapNotesShowEventToState() async* {
    yield NotesShow(_noteController, _titleController);
  }

  Stream<NotesState> _mapNotesUpdateEventToState(
      NotesUpdateEvent event) async* {
    _noteController = event.noteController;
    _titleController = event.titleController;
    yield NotesUpdated();
  }

  @override
  Future<void> close() {
    topBarSubscription.cancel();
    return super.close();
  }
}
