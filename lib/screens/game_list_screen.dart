import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';
import '../widgets/game_list/widgets.dart';
import '../widgets/snack_bars.dart';

/// Compiles all widgets used by the games list screen.
class GamesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData.copyWith(
          accentColor: primaryColor, splashColor: primaryColor),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TopBar(),
            ),
            Expanded(
              child: BlocBuilder<GamesBloc, GamesState>(
                builder: (context, state) {
                  if (state is GamesLoaded) {
                    final games = state.games;
                    return ListView.builder(
                      itemCount: games?.length ?? 0,
                      itemBuilder: (context, index) {
                        final game = games[index];
                        return GameItem(game, (_) {
                          BlocProvider.of<GamesBloc>(context)
                              .add(GamesDeleteEvent(game));
                          widgetSnackBar(
                            context,
                            'Game Deleted',
                            Text(
                              'Undo',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 26,
                                  color: secondaryColor),
                            ),
                            function: () => BlocProvider.of<GamesBloc>(context)
                                .add(GamesAddEvent(game)),
                          );
                        });
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
