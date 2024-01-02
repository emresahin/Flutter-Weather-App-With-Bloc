import 'package:equatable/equatable.dart';
import 'package:weather_app_with_bloc/model/weatherentity.dart';

class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherBlocState {}

final class WeatherBlocLoading extends WeatherBlocState {}

final class WeatherBlocFailure extends WeatherBlocState {
  final String message;
  const WeatherBlocFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class WeatherBlocSuccess extends WeatherBlocState {
  final WeatherEntity weather;

  const WeatherBlocSuccess(this.weather);

  @override
  List<Object> get props => [weather];
}
