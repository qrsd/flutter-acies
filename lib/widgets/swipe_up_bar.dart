import 'package:flutter/material.dart';

class SwipeUpBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Container(
        height: 80,
        color: Color(0xFF947FFD),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.keyboard_arrow_up,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  splashColor: Colors.grey,
                  onTap: () {
                    print('prs');
                  },
                  child: Image.asset(
                    'assets/coins.png',
                    width: 30,
                  ),
                ),
                Image.asset(
                  'assets/dice.png',
                  width: 30,
                ),
                Icon(
                  Icons.history,
                  size: 30,
                  color: Colors.white,
                ),
                Text(
                  'Reset',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
