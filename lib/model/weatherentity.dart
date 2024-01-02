class WeatherEntity {
  int id;
  DateTime dayOfDate;
  String temp;
  String weatherType;
  String iconType;
  String city;

  WeatherEntity(
      {required this.id,
      required this.dayOfDate,
      required this.temp,
      required this.weatherType,
      required this.iconType,
      required this.city});

  factory WeatherEntity.fromJson(Map<String, dynamic> json, String city) {
    return WeatherEntity(
        id: json['dt'],
        dayOfDate: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temp: '${double.parse(json['main']['temp'].toString()).round()}°C',
        weatherType: json['weather'][0]['main'],
        iconType: json['weather'][0]['icon'],
        city: city);
  }
}
