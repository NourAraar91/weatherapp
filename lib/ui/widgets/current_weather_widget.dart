import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/bloc/current_weather_bloc.dart';
import 'package:weatherapp/bloc/forcast_bloc.dart';
import 'package:weatherapp/bloc/geo_location_bloc.dart';
import 'package:weatherapp/models/current_weather.dart';
import 'package:weatherapp/models/forcast_result.dart';
import 'package:weatherapp/models/weather_result.dart';
import 'package:weatherapp/network/Repsonse.dart';
import 'package:weatherapp/ui/widgets/tempruter_text.dart';
import 'common_widgets/loading_widger.dart';
import 'package:weatherapp/extensions/extensions.dart';

import 'forcast_weather_widget.dart';

class CurrentWeartherWidget extends StatefulWidget {
  CurrentWeartherWidget({Key key, this.city}) : super(key: key);
  final String city;

  @override
  _CurrentWeartherWidgetState createState() => _CurrentWeartherWidgetState();
}

class _CurrentWeartherWidgetState extends State<CurrentWeartherWidget> {
  CurrentWeatherBloc weatherBloc;
  ForcastBloc forcastBloc;
  GeoLocationBloc locationBloc;

  @override
  void initState() {
    weatherBloc = CurrentWeatherBloc();
    forcastBloc = ForcastBloc();
    locationBloc = GeoLocationBloc();

    weatherBloc.getCurrentWeatherByName(widget.city);
    forcastBloc.getForcastByName(widget.city);
    locationBloc.currentPositionController.listen((value) {
      weatherBloc.getCurrentWeatherByLatAndLong(
          value.latitude.toString(), value.longitude.toString());
      forcastBloc.getForcastByLatAndLong(
          value.latitude.toString(), value.longitude.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 44, 44, 44),
      child: Stack(
        children: <Widget>[
          StreamBuilder<Response<CurrentWeather>>(
              stream: weatherBloc.currentResultStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Loading(loadingMessage: snapshot.data.message);
                      break;
                    case Status.COMPLETED:
                      var currentWeather = snapshot.data.data;
                      return buildMainContainer(currentWeather);
                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () =>
                            weatherBloc.getCurrentWeatherByName(widget.city),
                      );
                      break;
                  }
                }
                return Container();
              }),
          buildForcastWidget(),
        ],
      ),
    );
  }

  Positioned buildForcastWidget() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: 150,
      child: StreamBuilder<Response<ForcastResult>>(
          stream: forcastBloc.forcastResultStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.COMPLETED:
                  return buildForcastListContainer(snapshot.data.data.list);
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () =>
                        forcastBloc.getForcastByName(widget.city),
                  );
              }
            }
            return Container();
          }),
    );
  }

  Container buildForcastListContainer(List<WeatherResult> list) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: list.nthElement(8).map((WeatherResult element) {
              return ForcastWeatherWidget(element: element);
            }).toList()),
      ),
    );
  }

  Container buildMainContainer(CurrentWeather currentWeather) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: currentWeather.weather[0].image,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 44,
          ),
          buildMyLocationButton(),
          builDateWidget(currentWeather),
          buildTimeWidget(currentWeather),
          buildLocationWidget(currentWeather),
          buildWeatherWidget(currentWeather),
          SizedBox(
            height: 24,
          ),
          TempretureText(
            tempreture: currentWeather.main.temp.floor().toString(),
            style: TextStyle(fontSize: 92, color: Colors.white),
          ),
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
          locationBloc.getCurrentLocation();
        },
        icon: Icon(
          Icons.my_location,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }

  Column buildWeatherWidget(CurrentWeather currentWeather) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Image(
            width: 200,
            height: 200,
            fit: BoxFit.fill,
            image: AdvancedNetworkImage(
                'http://openweathermap.org/img/wn/${currentWeather.weather[0].icon}@2x.png',
                useDiskCache: true),
          ),
        ),
        Text(
          currentWeather.weather[0].description,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }

  Padding buildLocationWidget(CurrentWeather currentWeather) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        currentWeather.name,
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
      ),
    );
  }

  Padding buildTimeWidget(CurrentWeather currentWeather) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        currentWeather.dt.formatedDate(DateFormat.HOUR_MINUTE),
        style: TextStyle(color: Colors.white, fontSize: 32),
      ),
    );
  }

  Padding builDateWidget(CurrentWeather currentWeather) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        currentWeather.dt.formatedDate('EEEE, d MMM'),
        style: TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
