import 'package:flutter/material.dart';
import 'package:weatherworld/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/citybg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue[400],
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  enableInteractiveSelection: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter city Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.blue[400],
                      size: 30.0,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                textColor: Colors.blue[400],
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
