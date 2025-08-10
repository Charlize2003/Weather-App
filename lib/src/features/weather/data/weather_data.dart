class WeatherData {
  final WeatherParams parameters;
  final List<WeatherInfo> weatherInfo;
  final int timestamp;

  WeatherData({
    required this.parameters,
    required this.weatherInfo,
    required this.timestamp,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
  return WeatherData(
    parameters: WeatherParams.fromJson(json['main']),
    weatherInfo: (json['weather'] as List)
        .map((item) => WeatherInfo.fromJson(item))
        .toList(),
    timestamp: json['dt'],
  );
}


  @override
  bool operator == (Object other) => identical(this, other) ||
      other is WeatherData &&
      runtimeType == other.runtimeType &&
      parameters == other.parameters &&
      _listEquals(weatherInfo, other.weatherInfo) &&
      timestamp == other.timestamp;

  @override
  int get hashCode => parameters.hashCode ^ weatherInfo.hashCode ^ timestamp.hashCode;

  bool _listEquals(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

class WeatherParams {
  final double temp;
  final double tempMin;
  final double tempMax;

  WeatherParams({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  factory WeatherParams.fromJson(Map<String, dynamic> json) {
    return WeatherParams(
      temp: json['temp'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
    );
  }

  WeatherParams copyWith({
    double? temp,
    double? tempMin,
    double? tempMax,
  }) {
    return WeatherParams(
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
    );
  }

  @override
  bool operator == (Object other) => identical(this, other) ||
      other is WeatherParams &&
      runtimeType == other.runtimeType &&
      temp == other.temp &&
      tempMin == other.tempMin &&
      tempMax == other.tempMax;
  
  @override
  int get hashCode => temp.hashCode ^ tempMin.hashCode ^ tempMax.hashCode;
}

class WeatherInfo {
  final String description;
  final String icon;
  final String main;

  WeatherInfo({
    required this.description,
    required this.icon,
    required this.main,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      description: json['description'],
      icon: json['icon'],
      main: json['main'],
    );
  }

  @override
  bool operator == (Object other) => identical(this, other) ||
      other is WeatherInfo &&
      runtimeType == other.runtimeType &&
      description == other.description &&
      icon == other.icon &&
      main == other.main;
  
  @override
  int get hashCode => description.hashCode ^ icon.hashCode ^ main.hashCode;
}