import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/route_argument.dart';
import '../controllers/address_map_controller.dart';

import '../helpers/app_config.dart' as config;

class AddressByMapWidget extends StatefulWidget {
  AddressByMapWidget({Key key, this.routeArgument}) : super(key: key);
  RouteArgument routeArgument;
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends StateMVC<AddressByMapWidget> {
  AddressMapController _con;
  LatLng latlngObj;
  List list = new List();

  _MapWidgetState() : super(AddressMapController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, list);
        return Future<bool>.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Set your location",
            style: Theme.of(context).textTheme.title,
          ),
          leading: BackButton(
            color: config.Colors().mainDarkColor(1),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            _con.cameraPosition == null
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  )
                : GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapToolbarEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: _con.cameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _con.mapController.complete(controller);
                    },
                    onCameraMove: (CameraPosition cameraPosition) {
                      _con.cameraPosition = cameraPosition;
                      latlngObj = cameraPosition.target;
                    },
                    markers: Set<Marker>.of(_con.allMarkers),
                    onTap: (LatLng latlng) {
                      _con.setNewLocation(latlng);
                    },
                    onCameraIdle: () {},
                  ),
            Positioned(
              bottom: 10,
              child: ButtonTheme(
                minWidth: config.App(context).appWidth(90),
                height: config.App(context).appHeight(6),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: config.App(context).appWidth(5),
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      list.add(_con.myAddress);
                      list.add(_con.allMarkers);
                      Navigator.pop(context, list);
                    },
                    child: Text(
                      "Set location",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
