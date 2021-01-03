import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/setting_repository.dart' as settingRepo;

class Controller extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  Controller() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    super.initState();
    settingRepo.setCurrentLocation().then((locationData) {
      setState(() {
        settingRepo.locationData = locationData;
      });
    });
  }
}
