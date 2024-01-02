import 'package:equatable/equatable.dart';

class ForecastBlocEvent extends Equatable {
  const ForecastBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchForecast extends ForecastBlocEvent {
  final double lat;
  final double lon;

  const FetchForecast(this.lat, this.lon);

  @override
  List<Object> get props => [lat, lon];
}
