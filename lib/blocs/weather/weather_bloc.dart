// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:weather_app_with_bloc/blocs/weather/weather_event.dart';
import 'package:weather_app_with_bloc/blocs/weather/weather_state.dart';
import 'package:weather_app_with_bloc/model/weatherentity.dart';
import 'package:weather_app_with_bloc/services/weatherservice.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherService weatherService = WeatherService();

        WeatherEntity weather = await weatherService.getCurrentWeather(
          event.lat,
          event.lon,
        );

        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure(e.toString()));
      }
    });
  }
}
