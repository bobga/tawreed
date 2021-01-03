import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:string_validator/string_validator.dart';
import 'package:tawreed/src/controllers/customer_controller.dart';
import 'package:tawreed/src/models/route_argument.dart';
import '../helpers/app_config.dart' as config;
import '../repository/customer_repository.dart' as repo;
import '../models/address.dart' as model;

class BusinessInformation extends StatefulWidget {
  @override
  _BusinessInformationState createState() => _BusinessInformationState();
}

class _BusinessInformationState extends StateMVC<BusinessInformation> {
  CustomerController _con;
  final TextEditingController _location = new TextEditingController();

  model.Address myAddress;
  List<Marker> allMarkers = <Marker>[];

  bool isLoadingState = false;

  _BusinessInformationState() : super(CustomerController()) {
    _con = controller;
  }

  updateInfo(List info) {
    if (info != null) {
      addAddress(info[0]);
      addMarkers(info[1]);
    } else
      print("empty");

    print("all Markers");
    print(allMarkers);
  }

  void moveToAddressMap() async {
    final info = await Navigator.of(context)
        .pushNamed('/AddressByMap', arguments: new RouteArgument());
    updateInfo(info);
  }

  @override
  void initState() {
    super.initState();
    _con.fetchStateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/SignUp');
          },
          icon: Icon(
            Icons.arrow_back,
            color: config.Colors().mainDarkColor(1),
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Stack(
        children: [
          Container(
            height: config.App(context).appHeight(100),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: config.App(context).appHeight(3),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: config.App(context).appWidth(5),
                  ),
                  child: Text(
                    "Business information required",
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
                SizedBox(
                  height: config.App(context).appHeight(4),
                ),
                Form(
                  key: _con.formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: config.App(context).appWidth(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Business Identification information",
                          style: Theme.of(context).textTheme.display2,
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(1.2),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => repo.customer.partnerName = input,
                          validator: (String value) {
                            if (!isLength(value, 2, 100)) {
                              return "Business name  must be min 2, max 100";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Business name",
                            hintStyle: Theme.of(context).textTheme.display1,
                            prefixIcon: Tab(
                              icon: SvgPicture.asset(
                                "assets/img/business_person.svg",
                                width: 17,
                                height: 17,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            errorStyle: TextStyle(height: 0.4),
                          ),
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(4),
                        ),
                        Text(
                          "Business Identification information",
                          style: Theme.of(context).textTheme.display2,
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(1.2),
                        ),
                        DropdownButtonFormField(
                          validator: (value) {
                            if (isNull(value)) {
                              return "Business provinence is required";
                            } else
                              return null;
                          },
                          hint: Text(
                            "Business Provinence",
                            style: Theme.of(context).textTheme.display1,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).hintColor,
                          ),
                          items: _con.stateList
                              .map(
                                (map) => DropdownMenuItem(
                                  child: Text(
                                    map['name'],
                                    style: Theme.of(context).textTheme.display2,
                                  ),
                                  value: map['stateId'].toString(),
                                ),
                              )
                              .toList(),
                          onChanged: (val) => print(val),
                          onSaved: (input) =>
                              repo.customer.stateId = int.parse(input),
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.display1,
                            prefixIcon: Icon(
                              Icons.phone_iphone,
                              size: 20,
                              color: Theme.of(context).hintColor,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            errorStyle: TextStyle(height: 0.4),
                          ),
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(1.2),
                        ),
                        TextFormField(
                          onSaved: (input) => repo.customer.city = input,
                          validator: (String value) {
                            if (!isLength(value, 2, 100)) {
                              return "Business City must be min 2, max 100";
                            } else
                              return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Business City",
                            hintStyle: Theme.of(context).textTheme.display1,
                            prefixIcon: Icon(
                              Icons.corporate_fare_outlined,
                              size: 20,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            errorStyle: TextStyle(height: 0.4),
                          ),
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(1.2),
                        ),
                        TextFormField(
                          onSaved: (input) => repo.customer.street = input,
                          validator: (String value) {
                            if (!isLength(value, 2, 100)) {
                              return "Address must be min 2, max 100";
                            } else
                              return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: Theme.of(context).textTheme.display1,
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              size: 20,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            errorStyle: TextStyle(height: 0.4),
                          ),
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(4),
                        ),
                        Text(
                          "Make your location on the map below",
                          style: Theme.of(context).textTheme.display2,
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(1.2),
                        ),
                        TextFormField(
                          controller: _location,
                          validator: (value) {
                            if (isNull(value)) {
                              return "Location is required";
                            } else
                              return null;
                          },
                          readOnly: true,
                          onSaved: (input) {},
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Set your location",
                            hintStyle: Theme.of(context).textTheme.display1,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.my_location),
                              onPressed: () {
                                moveToAddressMap();
                              },
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            errorStyle: TextStyle(height: 0.4),
                          ),
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(1.2),
                        ),
                        Container(
                          width: config.App(context).appWidth(90),
                          height: config.App(context).appHeight(20),
                          child: myAddress != null
                              ? GoogleMap(
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _con.mapController.complete(controller);
                                  },
                                  initialCameraPosition: _con.cameraPosition,
                                  markers: Set<Marker>.of(allMarkers),
                                )
                              : Container(),
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(10.2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(79),
            child: ButtonTheme(
              minWidth: config.App(context).appWidth(90),
              height: config.App(context).appHeight(6),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: config.App(context).appWidth(5),
                ),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      isLoadingState = true;
                    });
                    if (_con.formKey.currentState.validate()) {
                      _con.formKey.currentState.save();
                      setState(() {
                        repo.customer.latitude = myAddress.latitude;
                        repo.customer.longitude = myAddress.longitude;
                      });
                      Navigator.of(context)
                          .pushReplacementNamed('/ConfirmSignUp');
                    } else {
                      setState(() {
                        isLoadingState = false;
                      });
                    }
                  },
                  child: isLoadingState == false
                      ? Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                        ),
                  color: isLoadingState == false
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).hintColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addAddress(model.Address address) {
    setState(() {
      _location.text = address.address;
      _con.cameraPosition = new CameraPosition(
        target: LatLng(
            double.parse(address.latitude), double.parse(address.longitude)),
        zoom: 14.4746,
      );
      myAddress = address;
    });
  }

  void addMarkers(List<Marker> markers) {
    setState(() {
      allMarkers = markers;
    });
  }
}
