import 'package:flutter/material.dart';
import 'package:weatherapp/bloc/current_wearther_widget_bloc.dart';
import 'package:weatherapp/models/place.dart';
import 'package:weatherapp/ui/pages/world_cities_page.dart';
import 'package:weatherapp/ui/widgets/current_weather_widget.dart';
import 'package:weatherapp/ui/widgets/navbar_widget.dart';
import 'package:weatherapp/utilities/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.weatherBloc}) : super(key: key);
  final CurrentWeartherWidgetBloc weatherBloc;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Place> cities;
  @override
  void initState() {
    cities = widget.weatherBloc.citiesBloc.getWorldCitiesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          CurrentWeartherWidget(
            weatherBloc: widget.weatherBloc,
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavBar(
                hideNavBar: true,
                leading: buildMyLocationButton(),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Router.present(
                          WorldCitiesPage(
                            items: cities.map((e) => e.city).toList(),
                            onSelectItem: (index, item) {
                              widget.weatherBloc.getCurrentWeatherByName(item);
                              widget.weatherBloc.getForcastByName(item);
                              Navigator.of(context).pop();
                              print('clicked');
                            },
                          ),
                          context);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Container buildMyLocationButton() {
    return Container(
      margin: EdgeInsets.only(left: 16.0),
      alignment: Alignment(-1, 0),
      child: IconButton(
        onPressed: () {
          widget.weatherBloc.getCurrentlocation();
        },
        icon: Icon(
          Icons.my_location,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}
