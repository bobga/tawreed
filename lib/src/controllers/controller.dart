import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Controller extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  Controller() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {}
}
