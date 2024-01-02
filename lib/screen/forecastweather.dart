import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_with_bloc/blocs/forecast/forecast_bloc.dart';
import 'package:weather_app_with_bloc/blocs/forecast/forecast_event.dart';
import 'package:weather_app_with_bloc/blocs/forecast/forecast_state.dart';
import 'package:weather_app_with_bloc/blocs/weather/weather_bloc.dart';

import 'package:weather_app_with_bloc/blocs/weather/weather_state.dart';
import 'package:weather_app_with_bloc/constants/colors.dart';
import 'package:weather_app_with_bloc/model/weatherentity.dart';
import 'package:weather_app_with_bloc/screen/weatherIcon.dart';

class ForecastWeather extends StatelessWidget {
  final Position position;
  const ForecastWeather(BuildContext context, this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ForecastBlocBloc>(context)
        .add(FetchForecast(position.latitude, position.longitude));
    return BlocBuilder<ForecastBlocBloc, ForecastBlocState>(
      builder: (context, state) {
        if (state is ForecastBlocSuccess) {
          return ForecaseWeatherDisplay(context, state.weathers);
        } else if (state is ForecastBlocFailure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  Padding ForecaseWeatherDisplay(
      BuildContext context, List<WeatherEntity> weathers) {
    final WeatherBlocBloc weatherBloc =
        BlocProvider.of<WeatherBlocBloc>(context);
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 10),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Yatay kaydırma
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: weathers.map((item) {
              return InkWell(
                onTap: () {
                  // ignore: invalid_use_of_visible_for_testing_member
                  weatherBloc.emit(WeatherBlocSuccess(item));
                },
                child: Container(
                  width: deviceWidth / 7,
                  height: 100.0,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: HexColor(sunnyBackgroundColor),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        DateFormat('dd MMM').format(item.dayOfDate),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      WeahterIcon(height: 30, width: 30, icon: item.iconType),
                      Text(
                        item.temp,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }
}
