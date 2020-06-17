import 'package:flutter/material.dart';
import 'package:weatherapp/ui/widgets/current_weather_widget.dart';

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
      body: CurrentWeartherWidget(
        city: 'Damascus',
      ),
    );
  }
}
