import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/controller.dart';
import '../widgets/player_widgets.dart';
import '../widgets/pad.dart';
import '../widgets/swipe_up_bar.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double _offset;
  String _delta;

  @override
  void initState() {
    _offset = 45;
    KeyController.listen((kb) => Brain.process(kb));
    Brain.listen(
      (delta) => setState(
        () {
          _delta = delta;
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212327),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TopBar(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PlayerColumn(PLAYER_1),
                CenterColumn(_delta),
                PlayerColumn(PLAYER_2),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * .6 - _offset,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .6,
                  minHeight: MediaQuery.of(context).size.height * .6 - 45),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    top: 0,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(
                          () {
                            _offset += details.primaryDelta * 3;
                          },
                        );
                      },
                      child: SwipeUpBar(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Pad(),
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

//<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a></div>
//<div>Icons made by <a href="https://www.flaticon.com/authors/gregor-cresnar" title="Gregor Cresnar">Gregor Cresnar</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a></div>
