import 'package:equatable/equatable.dart';
import 'package:weather_app_with_bloc/model/weatherentity.dart';

class ForecastBlocState extends Equatable {
  const ForecastBlocState();

  @override
  List<Object> get props => [];
}

final class ForecastBlocInitial extends ForecastBlocState {}

final class ForecastBlocLoading extends ForecastBlocState {}

final class ForecastBlocFailure extends ForecastBlocState {
  final String message;
  const ForecastBlocFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class ForecastBlocSuccess extends ForecastBlocState {
  final List<WeatherEntity> weathers;

  const ForecastBlocSuccess(this.weathers);

  @override
  List<Object> get props => [weathers];
}
