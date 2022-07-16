import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hamro_cinema/api/api_call.dart';
import 'package:hamro_cinema/constants/urls.dart';
import 'package:hamro_cinema/models/weather.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? weather;

  fetchWeatherData() async {
    final response = await APICall().getRequestWithToken(weatherApiUrl);
    weather = weatherFromJson(response);
    notifyListeners();
  }
}
