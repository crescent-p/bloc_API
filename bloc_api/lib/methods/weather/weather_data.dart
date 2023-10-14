import 'dart:convert';

import 'package:bloc_api/consts/keys.dart';
import 'package:bloc_api/methods/location/location_methods.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherData {
  String? cityName;
  double? maxTemp;
  String? main;
  String? description;
  String? icon;
  int? rainIntenstiy;
  String? locationKey;
  double? latitude;
  double? longitude;

  WeatherData(
      {this.description,
      this.rainIntenstiy,
      this.maxTemp,
      this.cityName,
      this.icon});

  Location location = Location();
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      // cityName: json['DailyForecasts'][0]["Temperature"]["Maximum"].toDouble().toString(),
      maxTemp: json['DailyForecasts'][0]["Temperature"]["Maximum"]["Value"].toDouble(),
      rainIntenstiy: json['Headline']["Severity"],
      description: json['Headline']["Text"],
    );
  }

  Future<void> getLocationKey(double latitude, double longitude) async {
    String apiUrl =
        'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=$apiKeyForAccuWeather&q=$latitude,$longitude';
    http.Response response = await http.get(Uri.parse(apiUrl));
    Map<String, dynamic> data = await jsonDecode(response.body);
    locationKey = data['Key'];
  }

  Future<WeatherData> getWeatherData() async {
    String checkPermission = await location.checkPermission();

    if (checkPermission == 'success') {
      await location.updateLocation();
      latitude = location.latitude;
      longitude = location.longitude;
    } else {
      print('Permission not granted');
    }

    await getLocationKey(latitude!, longitude!);

    String apiUrl =
        'http://dataservice.accuweather.com/forecasts/v1/daily/1day/$locationKey?apikey=$apiKeyForAccuWeather&language=en-us&details=false&metric=false';
    http.Response response = await http.get(Uri.parse(apiUrl));
    Map<String, dynamic> data = await jsonDecode(response.body);
    print(data);
    return WeatherData.fromJson(data);
  }
}
