import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/Screens/weather.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Weather();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.blue[900])]),
                padding: EdgeInsets.all(30),
                child: Image.asset("images/weatherlogo.png"))));
  }
}
