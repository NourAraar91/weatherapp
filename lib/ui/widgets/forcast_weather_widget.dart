import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:weatherapp/models/weather_result.dart';
import 'package:weatherapp/ui/widgets/tempruter_text.dart';
import 'package:weatherapp/extensions/extensions.dart';

class ForcastWeatherWidget extends StatelessWidget {
  const ForcastWeatherWidget({Key key, this.element}) : super(key: key);
  final WeatherResult element;
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 100,
        child: Column(
          children: <Widget>[
            Image(
              image: AdvancedNetworkImage(
                  'http://openweathermap.org/img/wn/${element.weather[0].icon}.png'),
            ),
            TempretureText(
              tempreture: element.main.temp.floor(),
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 44, 44, 44),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              element.dt.formatedDate('EEE,d'),
              style: TextStyle(
                  color: Color.fromARGB(255, 44, 44, 44),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
