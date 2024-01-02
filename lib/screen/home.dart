// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_with_bloc/blocs/forecast/forecast_bloc.dart';

import 'package:weather_app_with_bloc/blocs/weather/weather_bloc.dart';

import 'package:weather_app_with_bloc/screen/currentweather.dart';
import 'package:weather_app_with_bloc/screen/forecastweather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBlocBloc>(create: (context) => WeatherBlocBloc()),
          BlocProvider<ForecastBlocBloc>(
              create: (context) => ForecastBlocBloc())
        ],
        child: MaterialApp(
            home: FutureBuilder(
          future: getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                      child: Column(children: [
                    CurrentWeather(context, snapshot.data!),
                    ForecastWeather(context, snapshot.data!)
                  ])),
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        )));
  }
}

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location is not working');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Permissions are denied. Try again');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
