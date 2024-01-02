// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:weather_app_with_bloc/blocs/forecast/forecast_event.dart';
import 'package:weather_app_with_bloc/blocs/forecast/forecast_state.dart';

import 'package:weather_app_with_bloc/model/weatherentity.dart';
import 'package:weather_app_with_bloc/services/weatherservice.dart';

class ForecastBlocBloc extends Bloc<ForecastBlocEvent, ForecastBlocState> {
  ForecastBlocBloc() : super(ForecastBlocInitial()) {
    on<FetchForecast>((event, emit) async {
      emit(ForecastBlocLoading());
      try {
        WeatherService weatherService = WeatherService();

        List<WeatherEntity> weathers =
            await weatherService.getForecastWeatherList(event.lat, event.lon);

        emit(ForecastBlocSuccess(weathers));
      } catch (e) {
        emit(ForecastBlocFailure(e.toString()));
      }
    });
  }
}
