import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NotesState extends Equatable {
  const NotesState();
  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {
  final TextEditingController noteController;
  final TextEditingController titleController;

  NotesInitial(this.noteController, this.titleController);

  @override
  List<Object> get props => [noteController, titleController];
}

class NotesReset extends NotesState {}

class NotesSaving extends NotesState {
  final Map<String, dynamic> notes;

  NotesSaving(this.notes);

  @override
  List<Object> get props => [notes];
}

class NotesShow extends NotesState {
  final TextEditingController noteController;
  final TextEditingController titleController;

  NotesShow(this.noteController, this.titleController);

  @override
  List<Object> get props => [noteController, titleController];
}

class NotesUpdated extends NotesState {}
