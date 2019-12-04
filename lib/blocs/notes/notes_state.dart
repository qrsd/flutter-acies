import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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

class NotesShow extends NotesState {
  final TextEditingController noteController;
  final TextEditingController titleController;

  NotesShow(this.noteController, this.titleController);

  @override
  List<Object> get props => [noteController, titleController];
}

class NotesUpdated extends NotesState {}
