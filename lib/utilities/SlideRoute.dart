import 'package:flutter/material.dart';

class RouteTransition extends PageRouteBuilder<Widget> {
  RouteTransition({this.widget, this.fade = false})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          if (fade) {
            return FadeTransition(opacity: animation, child: child);
          }
          {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }
        });

  final Widget widget;
  final bool fade;
}
