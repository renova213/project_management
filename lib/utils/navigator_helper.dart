import 'package:flutter/material.dart';

class NavigatorHelper extends PageRouteBuilder {
  final Widget child;
  NavigatorHelper({required this.child})
      : super(
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
