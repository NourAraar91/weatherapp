import 'package:flutter/material.dart';
import 'SlideRoute.dart';

class Router {
  static void push(Widget page, BuildContext context) {
    Navigator.push(
      context,
      RouteTransition(
        widget: page,
        fade: true,
      ),
    );
  }

  static void pushReplacement(Widget page, BuildContext context) {
    Navigator.pushReplacement(
      context,
      RouteTransition(
        widget: page,
        fade: true,
      ),
    );
  }

  static void present(Widget page, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<Widget>(
          fullscreenDialog: true, builder: (BuildContext context) => page),
    );
  }
}
