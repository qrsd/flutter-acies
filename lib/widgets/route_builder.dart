import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// Build full page routes with varying transitions.
Route fullRouteBuilder(
    BuildContext context, Widget page, Offset begin, Offset end) {
  return PageRouteBuilder(
      opaque: false,
      barrierDismissible: true,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}

/// Build special sized page routes.
Route sizedRouteBuilder(BuildContext context, Widget page, double heightRatio,
    double widthRatio, Color color) {
  return PageRouteBuilder(
    opaque: false,
    barrierDismissible: true,
    pageBuilder: (context, animation, _) {
      return Center(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: color.withOpacity(animation.value == 1 ? 1 : 0),
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
            height: MediaQuery.of(context).size.height * heightRatio,
            width: MediaQuery.of(context).size.width * widthRatio,
            alignment: Alignment.center,
            child: page),
      );
    },
  );
}

/// Build special sized page routes wrapped with a gesture detector.
Route gestureDetectorRouteBuilder(
    BuildContext context, Widget page, Function onTap) {
  return PageRouteBuilder(
    opaque: false,
    barrierDismissible: true,
    pageBuilder: (context, animation, __) {
      return Center(
        child: GestureDetector(
          onTap: () => onTap(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: secondaryColor.withOpacity(animation.value == 1 ? 1 : 0),
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
            height: MediaQuery.of(context).size.width * .6,
            width: MediaQuery.of(context).size.width * .6,
            alignment: Alignment.center,
            child: page,
          ),
        ),
      );
    },
  );
}
