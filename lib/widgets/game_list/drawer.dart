import 'package:flutter/material.dart';

import '../../screens/screens.dart';
import '../../utils/constants.dart';
import '../route_builder.dart';
//import '../snack_bars.dart';

/// Left hand screen drawer, only displayed while in game list screen.
class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textSize = MediaQuery.of(context).size.width / 22;
    return Dismissible(
      onDismissed: (_) => Navigator.of(context).pop(),
      key: Key('drawer'),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: primaryColor,
          boxShadow: [
            const BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 5,
            )
          ],
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: const Alignment(.5, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
//                  FlatButton(
//                    child: Text(
//                      'settings',
//                      style: TextStyle(
//                        color: Colors.grey[800],
//                      ),
//                    ),
//                    onPressed: () => titleSnackBar(context, 'settings', 'wip'),
//                  ),
                  FlatButton(
                    child: Text(
                      'help',
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: textSize,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(fullRouteBuilder(
                          context, Help(), Offset(0.0, 1.0), Offset.zero));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    child: Text(
                      'about',
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: textSize,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(fullRouteBuilder(
                          context, About(), Offset(0.0, 1.0), Offset.zero));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
