import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  double temp;
  int dt;
  String icon;

  Weather({required this.temp, required this.dt, required this.icon});

  String getTempC() {
    return (temp - 273.15).toStringAsFixed(1);
  }

  String getDayOfWeek(int? timezoneOffset) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    dateTime = dateTime.add(Duration(milliseconds: timezoneOffset ?? 0));
    String formattedDate = DateFormat('EEEE').format(dateTime);
    return formattedDate;
  }

  String getDayAndMonth(int? timezoneOffset) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    dateTime = dateTime.add(Duration(milliseconds: timezoneOffset ?? 0));
    String formattedDate = DateFormat('MMM DD').format(dateTime);
    return formattedDate;
  }

  factory Weather.fromJson(Map<String, dynamic> data) {
    final dt = data['dt'] as int;
    final temp = data['temp']['eve'] as double;
    final icon = data['weather'][0]['icon'] as String;
    return Weather(temp: temp, dt: dt, icon: icon);
  }
}

class LocationWeather {
  String locationName;
  double lat;
  double lon;
  int? timezoneOffset;
  List<Weather>? daily;

  LocationWeather(
      {required this.locationName, required this.lat, required this.lon});

  Future<void> getLocationWeatherData() async {
    try {
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,current,minutely,alerts&appid=2ed34880c948e7e9434e5f951f96e18b');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        timezoneOffset = decodedResponse['timezone_offset'];
        var dataHourly = decodedResponse['daily'];

        daily = List<Weather>.from(dataHourly != null
            ? dataHourly.map((data) => Weather.fromJson(data)).toList()
            : <Weather>[]);
      }
    } catch (e) {
      print('e - $e');
    }
  }
}
