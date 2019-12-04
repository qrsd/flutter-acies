import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  TextEditingController _noteController;
  TextEditingController _titleController;

  NotesBloc() {
    _noteController = TextEditingController();
    _titleController = TextEditingController();
  }

  @override
  NotesState get initialState =>
      NotesInitial(this._noteController, this._titleController);

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is NotesShowEvent) {
      yield* _mapNotesShowEventToState();
    } else if (event is NotesUpdateEvent) {
      yield* _mapNotesUpdateEventToState(event);
    }
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
}
