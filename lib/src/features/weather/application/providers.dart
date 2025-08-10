import 'package:flutter/cupertino.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/api/api_keys.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/forecast_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';
import 'package:http/http.dart' as http;

class WeatherProvider extends ChangeNotifier {
  HttpWeatherRepository repository = HttpWeatherRepository(
    api: OpenWeatherMapAPI(sl<String>(instanceName: 'api_key')),
    client: http.Client(),
  );

  String city = 'London';
  WeatherData? currentWeatherProvider;
  ForecastData? hourlyWeatherProvider;

  WeatherProvider() {
    getWeatherData();
  }

  Future<void> getWeatherData() async {
    final weather = await repository.getWeather(location: city);
    //TODO set the weather and fetch forecast after
    currentWeatherProvider = weather;
    notifyListeners();
    await getForecastData();
  }

  Future<void> getForecastData() async {
    final forecast = await repository.getForecast(location: city);
    //TODO set the forecast
    final dailyAverageForecast = forecast.getDailyAverages();
    hourlyWeatherProvider = forecast;
    notifyListeners();
  }

  Future<void> setCity(String newCity) async {
    city = newCity;
    await getWeatherData();
  }
}
