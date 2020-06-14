import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}
