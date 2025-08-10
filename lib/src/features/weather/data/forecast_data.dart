import 'package:collection/collection.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_data.dart';

class ForecastData {
  final List<WeatherData> forecasts;

  ForecastData({required this.forecasts});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> forecastsList = json['list'];
    final forecasts = forecastsList.map((item) => WeatherData.fromJson(item)).toList();
    return ForecastData(forecasts: forecasts);
  }

  /// Returns a new list with one averaged WeatherData per day
  List<WeatherData> getDailyAverages() {
    final grouped = groupBy(forecasts, (WeatherData item) {
      final date = DateTime.fromMillisecondsSinceEpoch(item.timestamp * 1000);
      // Group by year-month-day only, no time
      return DateTime(date.year, date.month, date.day);
    });

    List<WeatherData> dailyAverages = [];

    grouped.forEach((date, dayForecasts) {
      final avgTemp = dayForecasts
          .map((e) => e.parameters.temp)
          .reduce((a, b) => a + b) /
          dayForecasts.length;

      final firstForecast = dayForecasts.first;

      final averagedForecast = WeatherData(
        timestamp: firstForecast.timestamp,
        parameters: firstForecast.parameters.copyWith(temp: avgTemp),
        weatherInfo: firstForecast.weatherInfo,
        // copy other fields if necessary
      );

      dailyAverages.add(averagedForecast);
    });

    return dailyAverages;
  }
}
