import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;

  SplashController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
