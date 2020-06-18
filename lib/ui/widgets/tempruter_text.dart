import 'package:flutter/material.dart';

/// this is a text that will show you a tempuretur in celsius
/// you shoule pass the tempreture in String 
/// and also can pass a Text style 

class TempretureText extends StatelessWidget {
  const TempretureText({Key key, @required this.tempreture, this.style})
      : super(key: key);

  final String tempreture;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: tempreture,
        children: [TextSpan(text: "°")],
        style: style,
      ),
    );
  }
}
