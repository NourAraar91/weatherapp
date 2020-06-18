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
                titleWidget: dropDown(),
                leading: buildMyLocationButton(),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Router.present(
                          WorldCitiesPage(
                            items: cities.map((e) => e.city).toList(),
                            onSelectItem: (index, item) {
                              widget.weatherBloc.citiesBloc.addNewCityToSelectedCities(item);
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

  dropDown() {
    return StreamBuilder<String>(
        stream: widget.weatherBloc.citiesBloc.selectedCityStream,
        builder: (context, snapshot) {
          return DropDown(
            items: widget.weatherBloc.citiesBloc.selectedCities,
            onSelecteItem: (index, item) {
              print(item);
              widget.weatherBloc.citiesBloc.addNewCityToSelectedCities(item);
              widget.weatherBloc.getCurrentWeatherByName(item);
              widget.weatherBloc.getForcastByName(item);
            },
            selectedItem: snapshot.hasData ? snapshot.data : null,
          );
        });
  }
}

class DropDown extends StatefulWidget {
  DropDown({Key key, this.items, this.onSelecteItem, this.selectedItem})
      : super(key: key);
  final List<String> items;
  final Function(int, String) onSelecteItem;
  final String selectedItem;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items != null) {
      var index = widget.items.indexOf(widget.selectedItem);
      if (index == -1) {
        index = 0;
      }
      dropdownValue = widget.items[index];
    }
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Color.fromARGB(255, 44, 44, 44),
        fontSize: 16,
      ),
      underline: Container(
        color: Colors.transparent,
      ),
      onChanged: (String newValue) {
        var index = widget.items.indexOf(newValue);
        widget.onSelecteItem(index, newValue);
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
