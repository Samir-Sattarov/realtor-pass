import 'package:flutter/cupertino.dart';

class AnimatedNavigation {
  static push({
    required BuildContext context,
    required Widget page,
  }) {
    return Navigator.push(context, CupertinoPageRoute(builder: (_) => page));
  }

  static pushAndRemoveUntilFade(
      {required BuildContext context, required Widget page}) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: 0.0, end: 1.0);
          final fadeAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static pushAndRemoveUntil({
    required BuildContext context,
    required Widget page,
  }) {
    return Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}
