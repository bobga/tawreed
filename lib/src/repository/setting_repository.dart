import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

LocationData locationData;

Future<LocationData> setCurrentLocation() async {
  var location = new Location();
  location.requestService().then((value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locationData = await location.getLocation();
      await prefs.setDouble('currentLat', locationData.latitude);
      await prefs.setDouble('currentLon', locationData.longitude);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  });
  return locationData;
}

Future<LocationData> getCurrentLocation() async {
  print("getCurrentLocation");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
    locationData = LocationData.fromMap({
      "latitude": prefs.getDouble('currentLat'),
      "longitude": prefs.getDouble('currentLon')
    });
  } else {
    setCurrentLocation().then((value) {
      if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
        locationData = LocationData.fromMap({
          "latitude": prefs.getDouble('currentLat'),
          "longitude": prefs.getDouble('currentLon')
        });
      }
    });
  }
  return locationData;
}
