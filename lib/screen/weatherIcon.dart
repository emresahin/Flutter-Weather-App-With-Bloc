import 'package:flutter/material.dart';

class WeahterIcon extends StatelessWidget {
  const WeahterIcon(
      {super.key,
      required this.icon,
      required this.height,
      required this.width});

  final String icon;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return getImageByWeatherType(icon);
  }

  Widget getImageByWeatherType(String icon) {
    icon = icon.substring(0, 2);
    AssetImage imageUrl = const AssetImage('lib/assets/images/windy.png');
    if (icon == '01') {
      imageUrl = const AssetImage('lib/assets/images/clear_sky.png');
    } else if (icon == '02') {
      imageUrl = const AssetImage('lib/assets/images/few_clouds.png');
    } else if (icon == '03' || icon == '04') {
      imageUrl = const AssetImage('lib/assets/images/clouds.png');
    } else if (icon == '09' || icon == '10') {
      imageUrl = const AssetImage('lib/assets/images/rain.png');
    } else if (icon == '11') {
      imageUrl = const AssetImage('lib/assets/images/thunderstorm.png');
    } else if (icon == '13') {
      imageUrl = const AssetImage('lib/assets/images/snow.png');
    } else if (icon == '50') {
      imageUrl = const AssetImage('lib/assets/images/windy.png');
    } else {
      imageUrl = const AssetImage('lib/assets/images/windy.png');
    }

    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageUrl,
            fit: BoxFit.cover,
          ),
        ));
  }
}
