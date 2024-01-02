import 'package:equatable/equatable.dart';

class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  final double lat;
  final double lon;

  const FetchWeather(this.lat, this.lon);

  @override
  List<Object> get props => [lat, lon];
}
