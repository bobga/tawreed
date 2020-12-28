import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/SignUp', arguments: 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: null,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/img/logo.svg',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30),
              Text(
                "Welcome to Tawreed",
                style: Theme.of(context).textTheme.display3,
              ),
              SizedBox(height: 10),
              Text(
                "The first B2B platform for medicin sourcing",
                style: Theme.of(context).textTheme.display2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
