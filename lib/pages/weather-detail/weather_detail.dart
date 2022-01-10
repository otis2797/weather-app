import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/pages/weather-detail/weather_detail_item.dart';
import 'package:weather/services/weather.dart';

class WeatherDetail extends StatefulWidget {
  const WeatherDetail({Key? key}) : super(key: key);

  @override
  _WeatherDetailState createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  List<Weather> daily = [];
  int? timezoneOffset;

  void getData() async {
    var instance = LocationWeather(
        locationName: 'Ho Chi Minh City', lat: 10.1399, lon: 106.3567);
    await instance.getLocationWeatherData();
    setState(() {
      timezoneOffset = instance.timezoneOffset;
      if (instance.daily != null) {
        daily = instance.daily!;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ho Chi Minh City',
          style: TextStyle(color: kColorGray2),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0,
      ),
      backgroundColor: kColorGrayF8,
      body: Container(
        padding: const EdgeInsets.all(0),
        child: ListView.builder(
            itemCount: daily.length,
            itemBuilder: (context, index) {
              return WeatherDetailItem(
                weather: daily[index],
                timezoneOffset: timezoneOffset,
              );
            }),
      ),
    );
  }
}
