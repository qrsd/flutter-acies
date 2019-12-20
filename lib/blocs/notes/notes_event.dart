import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Abstract of notes events.
abstract class NotesEvent extends Equatable {
  /// Constructor
  const NotesEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when a match is over.
class NotesMatchOverEvent extends NotesEvent {}

/// Event fires when notes needs to be reset.
class NotesResetEvent extends NotesEvent {}

/// Event fires when the notes widget is being displayed on screen.
class NotesShowEvent extends NotesEvent {}

/// Event fires when the notes widget has been updated.
class NotesUpdateEvent extends NotesEvent {
  /// [noteController] of note field.
  final TextEditingController noteController;

  /// [titleController] of title field.
  final TextEditingController titleController;

  /// Constructor
  NotesUpdateEvent(this.noteController, this.titleController);

  @override
  List<Object> get props => [noteController, titleController];
}
