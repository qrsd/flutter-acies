import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';

class Notes extends StatelessWidget {
  final double iconSize;

  Notes(this.iconSize);

  @override
  Widget build(BuildContext context) {
    TextEditingController _noteController;
    TextEditingController _titleController;
    return InkWell(
      onTap: () {
        BlocProvider.of<NotesBloc>(context).add(NotesShowEvent());
        Navigator.of(context)
            .push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            pageBuilder: (context, animation, __) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: secondaryColor
                        .withOpacity(animation.value == 1 ? 1 : 0),
                    boxShadow: animation.value == 1
                        ? [
                            const BoxShadow(
                              color: Colors.black45,
                              offset: Offset(3, 3),
                              blurRadius: 10,
                            ),
                          ]
                        : null,
                  ),
                  height: MediaQuery.of(context).size.height * .7,
                  width: MediaQuery.of(context).size.width * .8,
                  alignment: Alignment.center,
                  child: BlocBuilder<NotesBloc, NotesState>(
                    condition: (_, state) {
                      return state is NotesShow ? true : false;
                    },
                    builder: (context, state) {
                      _noteController = state.props[0];
                      _titleController = state.props[1];
                      return Material(
                        type: MaterialType.transparency,
                        child: KeyboardAvoider(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextField(
                                  controller: _titleController,
                                  autocorrect: false,
                                  maxLines: 1,
                                  cursorColor: primaryColor,
                                  textAlign: TextAlign.center,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                  ),
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Title...',
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      focusColor: primaryColor),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextField(
                                      controller: _noteController,
                                      autocorrect: false,
                                      maxLines: null,
                                      cursorColor: primaryColor,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22,
                                      ),
                                      decoration: InputDecoration.collapsed(
                                          hintText: 'Notes...',
                                          hintStyle: TextStyle(
                                            color: Colors.white70,
                                          ),
                                          focusColor: primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        )
            .then(
          (_) {
            BlocProvider.of<NotesBloc>(context)
                .add(NotesUpdateEvent(_noteController, _titleController));
            SystemChrome.restoreSystemUIOverlays();
          },
        );
      },
      child: Icon(
        Icons.create,
        size: iconSize,
      ),
    );
  }
}
