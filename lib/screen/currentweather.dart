import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_with_bloc/blocs/forecast/forecast_bloc.dart';
import 'package:weather_app_with_bloc/blocs/forecast/forecast_event.dart';
import 'package:weather_app_with_bloc/blocs/weather/weather_bloc.dart';
import 'package:weather_app_with_bloc/blocs/weather/weather_event.dart';
import 'package:weather_app_with_bloc/blocs/weather/weather_state.dart';
import 'package:weather_app_with_bloc/constants/colors.dart';
import 'package:weather_app_with_bloc/model/weatherentity.dart';
import 'package:weather_app_with_bloc/screen/gradienttext.dart';
import 'package:weather_app_with_bloc/screen/weatherIcon.dart';

class CurrentWeather extends StatelessWidget {
  final Position position;
  const CurrentWeather(BuildContext context, this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherBlocBloc>(context)
        .add(FetchWeather(position.latitude, position.longitude));

    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          return CurrentWeatherDisplayWidget(context, state.weather);
        } else if (state is WeatherBlocFailure) {
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
  Container CurrentWeatherDisplayWidget(
      BuildContext context, WeatherEntity currentWeather) {
    TextEditingController _textFieldController = TextEditingController();
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight * 0.70,
      width: deviceWidth,
      decoration: BoxDecoration(
        color: HexColor(sunnyBackgroundColor),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      ),
      child: Column(
        children: [
          TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                  labelText: 'Enter a city name',
                  labelStyle: TextStyle(color: Colors.white)),
              onSubmitted: (String value) {
                if (value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('City is required'),
                    ),
                  );
                } else {
                  getLocationByCity(value).then((cityPosition) {
                    BlocProvider.of<WeatherBlocBloc>(context).add(FetchWeather(
                        cityPosition.latitude, cityPosition.longitude));

                    BlocProvider.of<ForecastBlocBloc>(context).add(
                        FetchForecast(
                            cityPosition.latitude, cityPosition.longitude));
                  });
                }
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ImageIcon(
                  AssetImage('lib/assets/images/location.png'),
                  color: Colors.white,
                ),
                Text(
                  currentWeather.city,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
          GradientText(
            currentWeather.temp,
            style: const TextStyle(
                fontSize: 100,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color.fromARGB(196, 186, 200, 248),
                ]),
          ),
          WeahterIcon(height: 96, width: 96, icon: currentWeather.iconType),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(currentWeather.weatherType,
                style: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 10,
                    fontSize: 24,
                  ),
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(DateFormat('EEEE').format(currentWeather.dayOfDate),
                      style: GoogleFonts.rubik(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 5,
                            fontSize: 18),
                      )),
                  Text(
                    DateFormat('dd/MM/yyyy').format(currentWeather.dayOfDate),
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          color: Colors.white, letterSpacing: 5, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<Location> getLocationByCity(String city) async {
  List<Location> locations = await locationFromAddress(city);
  return locations[0];
}
