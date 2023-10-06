import 'dart:convert';

import 'package:bloc_api/consts/keys.dart';
import 'package:bloc_api/methods/location/location_methods.dart';
import 'package:http/http.dart' as http;

class WeatherData {
  String? cityName;
  double? mintemp;
  double? maxtemp;
  bool? dayRain;
  bool? nightRain;
  String? description;
  String? main;
  String? icon;
  int? severity;
  String? locationKey;
  double? latitude;
  double? longitude;

  WeatherData(
      {this.cityName, this.mintemp, this.maxtemp, this.main, this.icon, this.dayRain, this.nightRain, this.description, this.severity});

  Location location = Location();
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      mintemp: json['main']['temp'].toDouble(),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      // rainIntenstiy: if()
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
    getLocationKey(latitude!, longitude!);
    //await getLocationKey(latitude!, longitude!);

    String apiUrl =
        'http://dataservice.accuweather.com/forecasts/v1/daily/1day/$locationKey/forecasts/v1/daily/1day/2875590?apikey=$apiKeyForAccuWeather&language=en-us&details=false&metric=0';
    http.Response response = await http.get(Uri.parse(apiUrl));
    Map<String, dynamic> data = await jsonDecode(response.body);
    WeatherData weatherData = WeatherData(
        mintemp: data["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"]
            .toDouble(),
        maxtemp: data["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"]
            .toDouble(),
        main: data["DailyForecasts"][0]["Day"]["IconPhrase"],
        icon: data["DailyForecasts"][0]["Day"]["Icon"].toString(),
        dayRain: data["DailyForecasts"][0]["Day"]["HasPrecipitation"],
        nightRain: data["DailyForecasts"][0]["Night"]["HasPrecipitation"],
        description: data["Headline"]["Text"],
        severity: data["Headline"]["Severity"]);

    return weatherData;
  }
}
