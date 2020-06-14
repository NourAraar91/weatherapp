import 'dart:async' show Future;
import 'dart:convert' show json;
import 'dart:io' show SocketException;
import 'package:http/http.dart';
import 'package:weatherapp/network/CustomException.dart';
import 'package:http/http.dart' as http;


class ApiProvider {
  final String _baseUrl = 'https://api.openweathermap.org/';

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final Response response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final dynamic responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
