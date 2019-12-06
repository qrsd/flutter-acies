import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
  @override
  List<Object> get props => [];
}

class NotesMatchOverEvent extends NotesEvent {}

class NotesResetEvent extends NotesEvent {}

class NotesShowEvent extends NotesEvent {}

class NotesUpdateEvent extends NotesEvent {
  final TextEditingController noteController;
  final TextEditingController titleController;

  NotesUpdateEvent(this.noteController, this.titleController);

  @override
  List<Object> get props => [noteController, titleController];
}
