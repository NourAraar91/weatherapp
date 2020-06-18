import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/bloc/current_wearther_widget_bloc.dart';
import 'package:weatherapp/models/current_weather.dart';
import 'package:weatherapp/models/forcast_result.dart';
import 'package:weatherapp/models/weather_result.dart';
import 'package:weatherapp/network/Repsonse.dart';
import 'package:weatherapp/ui/widgets/tempruter_text.dart';
import 'common_widgets/loading_widger.dart';
import 'common_widgets/error_widget.dart';
import 'package:weatherapp/extensions/extensions.dart';

import 'forcast_weather_widget.dart';

class CurrentWeartherWidget extends StatefulWidget {
  CurrentWeartherWidget({Key key, this.weatherBloc}) : super(key: key);
  final CurrentWeartherWidgetBloc weatherBloc;
  @override
  _CurrentWeartherWidgetState createState() => _CurrentWeartherWidgetState();
}

class _CurrentWeartherWidgetState extends State<CurrentWeartherWidget> {
  CurrentWeartherWidgetBloc bloc;
  String currentCity;

  @override
  void initState() {
    bloc = widget.weatherBloc;
    currentCity = bloc.currentCity;
    bloc.getCurrentWeatherByName(currentCity);
    bloc.getForcastByName(currentCity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 44, 44, 44),
      child: Stack(
        children: <Widget>[
          StreamBuilder<Response<CurrentWeather>>(
              stream: bloc.currentResultStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Loading(loadingMessage: snapshot.data.message);
                      break;
                    case Status.COMPLETED:
                      var currentWeather = snapshot.data.data;
                      bloc.setCurrentCityCache(currentWeather.name);
                      return buildMainContainer(currentWeather);
                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () =>
                            bloc.getCurrentWeatherByName(currentCity),
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
          stream: bloc.forcastResultStream,
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
                    onRetryPressed: () => bloc.getForcastByName(currentCity),
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
            children: list.everyNthElement(8).map((WeatherResult element) {
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
          image: currentWeather.weather.first.image ?? '',
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 72,
          ),
          builDateWidget(currentWeather),
          buildTimeWidget(currentWeather),
          buildLocationWidget(currentWeather),
          buildWeatherWidget(currentWeather),
          SizedBox(
            height: 16,
          ),
          TempretureText(
            tempreture: currentWeather.main.temp.floor().toString(),
            style: TextStyle(fontSize: 92, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Column buildWeatherWidget(CurrentWeather currentWeather) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Image(
            fit: BoxFit.fill,
            image: AdvancedNetworkImage(
                'http://openweathermap.org/img/wn/${currentWeather.weather.first.icon}@2x.png',
                useDiskCache: true),
          ),
        ),
        Text(
          currentWeather.weather.first.description ?? '',
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
