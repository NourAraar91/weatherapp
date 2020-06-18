import 'package:flutter/material.dart';
import 'package:weatherapp/bloc/current_wearther_widget_bloc.dart';
import 'package:weatherapp/datastore/datastore.dart';
import 'package:weatherapp/ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataStore.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Barlow'),
      home: HomePage(
        weatherBloc: CurrentWeartherWidgetBloc(),
      ),
    );
  }
}
