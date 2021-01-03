import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:tawreed/src/helpers/helper.dart';
import '../repository/setting_repository.dart' as sett;
import '../models/address.dart' as model;

class AddressMapController extends ControllerMVC {
  BuildContext context;
  LocationData currentLocation;
  CameraPosition cameraPosition;
  Completer<GoogleMapController> mapController = Completer();
  List<Marker> allMarkers = <Marker>[];
  model.Address myAddress;

  GlobalKey<ScaffoldState> scaffoldKey;
  AddressMapController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getCurrentLocation();
    sett.setCurrentLocation().then((locationData) {
      setState(() {
        sett.locationData = locationData;
      });
    });
  }

  void getCurrentLocation() async {
    try {
      currentLocation = await sett.getCurrentLocation();
      final coordinates =
          new Coordinates(currentLocation.latitude, currentLocation.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      setState(() {
        cameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 14.4746,
        );
      });
      Helper.getMyPositionMarker(
              currentLocation.latitude, currentLocation.longitude)
          .then((marker) {
        marker = new Marker(
            markerId: marker.markerId,
            icon: marker.icon,
            anchor: marker.anchor,
            position: marker.position,
            onTap: () {});
        setState(() {
          allMarkers.clear();
          allMarkers.add(marker);
        });
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }

  Future<void> setNewLocation(LatLng latLng) async {
    final coordinates = new Coordinates(latLng.latitude, latLng.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Helper.getMyPositionMarker(latLng.latitude, latLng.longitude)
        .then((marker) {
      marker = new Marker(
          markerId: marker.markerId,
          icon: marker.icon,
          anchor: marker.anchor,
          position: marker.position,
          onTap: () {});
      setState(() {
        model.Address address = new model.Address();
        var first = addresses.first;
        address.address = first.addressLine;
        address.latitude = latLng.latitude.toString();
        address.longitude = latLng.longitude.toString();
        addAddress(address);
        allMarkers.clear();
        allMarkers.add(marker);

        print("All markes: $marker");
      });
    });
  }

  void addAddress(model.Address address) {
    myAddress = address;
  }
}
