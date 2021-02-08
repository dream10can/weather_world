import 'package:weatherworld/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:weatherworld/utilities/constants.dart';
import 'package:weatherworld/services/weather.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:weatherworld/screens/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;

  WeatherModel weather = WeatherModel();

  var temperature;

  String iconCondition;

  String description;

  String iconMessage;

  String cityName;

  String typedValue;

  final ams = AdMobService();

  @override
  void initState() {
    super.initState();

    Admob.initialize(ams.getAdMobAppId());

    updateData(widget.locationWeather);

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  void updateData(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        iconCondition = 'Error';
        iconMessage = 'Unable to get weather data';
        cityName = '';
        description = '';

        return;
      }

      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      iconCondition = weather.getWeatherIcon(condition);

      iconMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];

      description = weatherData['weather'][0]['description'];
    });
  }

  @override
  Widget build(BuildContext context) {
    InterstitialAd newVideoAd = ams.getNewInterstitial();

    newVideoAd.load();

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '$cityName',
                      style: kTextTime,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var weatherData = await weather.getLocationWeather();

                        updateData(weatherData);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 150.0),
                        child: Icon(
                          Icons.my_location,
                          size: 35.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        newVideoAd.show(
                          anchorType: AnchorType.bottom,
                          anchorOffset: 0.0,
                          horizontalCenterOffset: 0.0,
                        );

                        var typedValue = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );

                        if (typedValue != null) {
                          var weatherData =
                              await weather.getCityWeather(typedValue);

                          updateData(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 35.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Image(
                height: animation.value * 170,
                width: animation.value * 170,
                image: AssetImage(
                  'assets/$iconCondition',
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                '$temperature °',
                style: kTempStyle,
              ),
              Divider(
                height: 20.0,
                color: Colors.grey[100],
                thickness: 1.0,
                indent: 140,
                endIndent: 140,
              ),
              Text(
                '$description',
                style: kTempStyle,
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                '$iconMessage',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                ),
              ),
              AdmobBanner(
                adUnitId: ams.getBannerAdId(),
                adSize: AdmobBannerSize.FULL_BANNER,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
