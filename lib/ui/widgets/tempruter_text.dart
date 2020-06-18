import 'dart:async';

import 'package:flutter/material.dart';

/// this is a text that will show you a tempuretur in celsius
/// you shoule pass the tempreture as int
/// and also can pass a Text style

class TempretureText extends StatefulWidget {
  const TempretureText({Key key, @required this.tempreture, this.style})
      : super(key: key);

  final int tempreture;
  final TextStyle style;

  @override
  _TempretureTextState createState() => _TempretureTextState();
}

class _TempretureTextState extends State<TempretureText> {
  String value;
  Timer timer;
  void startTimer() {
    int i = 0;
    // Start the periodic timer which prints something every 1 seconds
    timer = new Timer.periodic(new Duration(milliseconds: 10), (time) {
      if (i >= widget.tempreture) {
        timer.cancel();
      }
      i += 1;
      setState(() {
        value = i.toString();
      });
    });
  }

@override
  void initState() {
    
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: value,
        children: [TextSpan(text: "°")],
        style: widget.style,
      ),
    );
  }
}
