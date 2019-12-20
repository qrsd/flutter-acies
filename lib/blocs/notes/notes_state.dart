import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Abstract of notes state.
abstract class NotesState extends Equatable {
  /// Constructor
  const NotesState();

  @override
  List<Object> get props => [];
}

/// Initial notes state.
class NotesInitial extends NotesState {
  /// [noteController] of note field.
  final TextEditingController noteController;

  /// [titleController] of title field.
  final TextEditingController titleController;

  /// Constructor
  NotesInitial(this.noteController, this.titleController);

  @override
  List<Object> get props => [noteController, titleController];
}

/// State yielded when both controllers need to be reset.
class NotesReset extends NotesState {}

/// State yielded when controllers are being saved to file after a match ends.
class NotesSaving extends NotesState {
  /// [notes] contains title and notes.
  final Map<String, dynamic> notes;

  /// Constructor
  NotesSaving(this.notes);

  @override
  List<Object> get props => [notes];
}

/// State yielded when the notes widget is being displayed. Grabs the
/// controllers and sends them to the widget.
class NotesShow extends NotesState {
  /// [noteController] of note field.
  final TextEditingController noteController;

  /// [titleController] of title field.
  final TextEditingController titleController;

  /// Constructor
  NotesShow(this.noteController, this.titleController);

  @override
  List<Object> get props => [noteController, titleController];
}

/// State yielded when controllers are updated after user disposes of
/// the notes widget.
class NotesUpdated extends NotesState {}
