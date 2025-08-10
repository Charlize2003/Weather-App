import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_data.dart';
import 'package:provider/provider.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/forecast_data.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<WeatherProvider, ForecastData?>(
      selector: (context, provider) => provider.hourlyWeatherProvider,
      builder: (context, forecast, _) {
        if (forecast == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (forecast.forecasts.isEmpty) {
          return const Center(child: Text('No forecast data available'));
        }

        return Container(
          color: Colors.blue.shade700, // background similar to image
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: forecast.forecasts.map((item) {
                return Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ForecastItem(forecastItem: item));
              }).toList(),
            ),
          )
        );
      },
    );
  }
}

class ForecastItem extends StatelessWidget {
  final WeatherData forecastItem;

  const ForecastItem({required this.forecastItem, super.key});

  String getDayAbbreviation(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final temp = '${forecastItem.parameters.temp.toInt()}°';

    final dateTime = DateTime.fromMillisecondsSinceEpoch(forecastItem.timestamp * 1000);
    final day = getDayAbbreviation(dateTime);

    final icon = forecastItem.weatherInfo.isNotEmpty ? forecastItem.weatherInfo[0].icon : '01d';
    final iconUrl = 'https://openweathermap.org/img/wn/$icon@2x.png';
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          day,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Image.network(iconUrl, width: 40, height: 40),
        const SizedBox(height: 8),
        Text(
          temp,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
