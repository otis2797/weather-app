import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/services/weather.dart';

class WeatherDetailItem extends StatelessWidget {
  final Weather weather;
  final int? timezoneOffset;

  WeatherDetailItem({required this.weather, this.timezoneOffset});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.fromLTRB(
          kMediumPading, kMediumPading, kMediumPading, 0),
      child: Padding(
        padding: const EdgeInsets.all(kLargePading),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(weather.getDayOfWeek(timezoneOffset),
                      style: const TextStyle(
                          color: kColorGray5,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text(weather.getDayAndMonth(timezoneOffset),
                      style: const TextStyle(
                          color: kColorGray5,
                          fontSize: 13,
                          fontWeight: FontWeight.normal))
                ],
              ),
            ),
            Text('${weather.getTempC()}°C',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold)),
            Image.asset(
              'assets/icons/${weather.icon}.png',
              fit: BoxFit.fill,
              width: 60,
              height: 60,
              alignment: Alignment.center,
            )
          ],
        ),
      ),
    );
  }
}
