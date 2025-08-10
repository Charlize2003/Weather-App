import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/forecast_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_data.dart';

class HttpWeatherRepository {
  // This class has been added to handle fetching the current weather and weather forecast of a certain location.

  final OpenWeatherMapAPI api;
  final http.Client client;

  HttpWeatherRepository({required this.api, required this.client});

  Future<WeatherData> getWeather({required String location}) async {
    final url = api.weather(location);
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return WeatherData.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('City not found: $location');
    } else {
      throw Exception('Failed to load weather data');
    }
    
  }

  Future<ForecastData> getForecast({required String location}) async {
    final url = api.forecast(location);
    final response = await client.get(url);
    return ForecastData.fromJson(jsonDecode(response.body));
  }
}