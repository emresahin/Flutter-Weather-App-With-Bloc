import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_with_bloc/constants/parameters.dart';
import 'package:weather_app_with_bloc/model/weatherentity.dart';

class WeatherService {
  Future<List<WeatherEntity>> getForecastWeatherList(
      double lat, double lon) async {
    String url = weatherAPIUrl;

    url = "${url}forecast?lat=$lat&lon=$lon&appid=$weatherAPIKey&units=metric";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> resp = jsonDecode(response.body)["list"];
      List<WeatherEntity> weatherModelList = List.empty(growable: true);

      for (var element in resp) {
        WeatherEntity task = WeatherEntity.fromJson(
            element, jsonDecode(response.body)['city']['name'].toString());

        bool isAddElement = true;
        if (weatherModelList.isNotEmpty) {
          WeatherEntity lastItem = weatherModelList.last;
          // ignore: unnecessary_null_comparison
          isAddElement =
              lastItem.dayOfDate.add(const Duration(days: 1)) == task.dayOfDate;
        }

        if (isAddElement == true) {
          weatherModelList.add(task);
        }
      }

      return weatherModelList;
    } else {
      throw Exception('$apiErrorMessage ${response.statusCode}');
    }
  }

  Future<WeatherEntity> getCurrentWeather(double lat, double lon) async {
    String url = weatherAPIUrl;

    url = "${url}weather?lat=$lat&lon=$lon&appid=$weatherAPIKey&units=metric";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final weatherModel = WeatherEntity.fromJson(
          data, jsonDecode(response.body)['name'].toString());

      return weatherModel;
    } else {
      throw Exception('$apiErrorMessage ${response.statusCode}');
    }
  }
}
