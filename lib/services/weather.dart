import 'package:weatherworld/services/location.dart';

import 'package:weatherworld/services/networking.dart';

const apiKey = 'de5c6203adb338f5afbc9b84bf8ce2fc';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkHelper =
        NetworkHelper('$openWeatherMapURL?lat=${location.latitude}'
            '&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '300.png';
    } else if (condition < 400) {
      return '400.png';
    } else if (condition < 600) {
      return '600.png';
    } else if (condition < 700) {
      return '700.png';
    } else if (condition < 800) {
      return '800.png';
    } else if (condition == 800) {
      return '800exactly.png';
    } else if (condition <= 804) {
      return '804.png';
    } else {
      return '300.png‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
