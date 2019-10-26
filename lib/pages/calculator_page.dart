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

  @override
  void initState() {
    _offset = .04;
    KeyController.listen((kb) => Brain.process(kb));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212327),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: const Alignment(0, -1),
              child: TopBar(),
            ),
          ),
          Align(
            alignment: const Alignment(0, -.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PlayerColumn(PLAYER_1),
                StreamBuilder(
                  stream: Brain.deltaStream,
                  builder: (context, snapshot) {
                    return CenterColumn(snapshot.data);
                  },
                ),
                PlayerColumn(PLAYER_2),
              ],
            ),
          ),
          StreamBuilder(
            stream: Brain.swipeStream,
            builder: (context, snapshot) {
              return GestureDetector(
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  _offset += details.primaryDelta * .003;
                  if (_offset > .04) {
                    _offset = .04;
                  } else if (_offset < -.09) {
                    _offset = -.09;
                  }
                  Brain.swipeController.add(_offset);
                },
                child: Align(
                    alignment: snapshot.hasData
                        ? Alignment(
                            0,
                            snapshot.data >= -.09
                                ? (snapshot.data <= .04 ? snapshot.data : -.09)
                                : .04)
                        : Alignment(0, .04),
                    child: SwipeUpBar()),
              );
            },
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: Pad(),
          ),
        ],
      ),
    );
  }
}

//<div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a></div>
//<div>Icons made by <a href="https://www.flaticon.com/authors/gregor-cresnar" title="Gregor Cresnar">Gregor Cresnar</a> from <a href="https://www.flaticon.com/"             title="Flaticon">www.flaticon.com</a></div>
