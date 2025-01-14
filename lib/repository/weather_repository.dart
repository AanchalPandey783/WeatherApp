import 'dart:convert' as convert;
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather_getx/data/location_data.dart';
import 'package:weather_getx/data/weather_data.dart';

class WeatherRepository {
  /// TODO: Your Api Key
  final apiKey = "a397e64ab81b30ecf7ea6087ef03790e";

  Future<LocationData?> getCurrentLocation() async {
    LocationData? locationData;
    final url = Uri.http('ip-api.com', '/json');

    final response = await http.get(url);
    print('${response.statusCode} getresponse');

    if (response.statusCode == 200) {
      final jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

      print(jsonResponse);
      locationData = LocationData.fromJson(jsonResponse);
      print(jsonResponse);
      log('Request successful: $jsonResponse');
      return locationData;
    } else {
      log('Request failed with status: ${response.statusCode}.');
      return locationData;
    }
  }

  Future<WeatherData?> getWeatherForLocation(LocationData location) async {
    WeatherData? weather;

    final params = {
      'lat': location.lat.toString(),
      'lon': location.lon.toString(),
      'city': location.regionName,
      'appId': apiKey,
    };
    final url = Uri.http('api.openweathermap.org', '/data/2.5/weather', params);
    final Response response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      final jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      weather = WeatherData.fromJson(jsonResponse);
      log('Request successful: $jsonResponse');
      return weather;
    } else {
      log('Request failed with status: ${response.statusCode}.');
      return weather;
    }
  }
}