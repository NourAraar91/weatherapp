import 'package:flutter/material.dart';
import 'package:weatherapp/ui/widgets/navbar_widget.dart';
import 'package:weatherapp/ui/widgets/search_bar_text_field_widget.dart';
import 'package:weatherapp/ui/widgets/text_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: NavBar(title: 'Weather App'),
        body: Container());
  }
}
