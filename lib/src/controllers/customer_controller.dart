import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../models/customer.dart';
import '../repository/setting_repository.dart' as sett;
import '../helpers/helper.dart';

class CustomerController extends ControllerMVC {
  GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  List<String> phoneCodeList = [];
  List<Map> stateList = [];
  bool isUnique = false;

  CameraPosition cameraPosition;
  LocationData currentLocation;
  Completer<GoogleMapController> mapController = Completer();

  CustomerController() {
    formKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    fetchPhoneCodeList();
    getCurrentLocation();
  }

  Future<bool> register(Customer customer) async {
    final String url =
        '${GlobalConfiguration().getString('api_base_url')}v1/customers/public/register';
    Map map = {
      "langCode": "en",
      "data": {
        "firstName": customer.firstName,
        "lastName": customer.lastName,
        "phoneCode": customer.phoneCode,
        "mobileNo": customer.mobileNo,
        "password": customer.password,
        "subscribeNewsLetter": customer.subscribeNewsLetter,
        "partnerName": customer.partnerName,
        "stateId": customer.stateId,
        "city": customer.city,
        "street": customer.street,
        "latitude": customer.latitude,
        "longitude": customer.longitude,
        "code": customer.code
      }
    };

    List<int> body = utf8.encode(json.encode(map));

    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.contentLengthHeader: body.length.toString(),
      },
      body: body,
    );

    if (response.statusCode == 200) {
      if (json.decode(response.body)['status'] == 500) {
        return false;
      } else
        return true;
    }
    return false;
  }

  // Fetch phone code list from sites-get-all api
  Future<void> fetchPhoneCodeList() async {
    final String url =
        '${GlobalConfiguration().getString('api_base_url')}v1/common/public/sites/all';

    Map map = {"langCode": "en"};
    List<int> body = utf8.encode(json.encode(map));

    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.contentLengthHeader: body.length.toString(),
      },
      body: body,
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data']);
      var values = json.decode(response.body)['data'];
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            setState(() {
              phoneCodeList.add(map['phoneCode'].toString());
            });
          }
        }
      }
      print(phoneCodeList);
    }
  }

  // Check mobile is unique or not from validate-mobile-unique api

  Future<void> isMobileUnique(String mobile) async {
    final String url =
        '${GlobalConfiguration().getString('api_base_url')}v1/auth/public/users/mobile/validate/unique';
    Map map = {"langCode": "en", "data": mobile};
    List<int> body = utf8.encode(json.encode(map));
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.contentLengthHeader: body.length.toString(),
      },
      body: body,
    );
    if (response.statusCode == 200) {
      if (json.decode(response.body)['status'] == 500) {
        isUnique = false;
      } else {
        isUnique = true;
      }
    } else
      setState(() {
        isUnique = false;
      });
  }

  Future<String> sendOTP(String mobile) async {
    final String url =
        '${GlobalConfiguration().getString('api_base_url')}v1/auth/public/otp/send';
    Map map = {"langCode": "en", "data": mobile};
    List<int> body = utf8.encode(json.encode(map));
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.contentLengthHeader: body.length.toString(),
      },
      body: body,
    );
    if (response.statusCode == 200) {
      print("OTP code");
      print(json.decode(response.body));
      return json.decode(response.body)['data'];
    }
    return null;
  }

  Future<int> sendVerificationCode(String mobile, String code) async {
    final String url =
        '${GlobalConfiguration().getString('api_base_url')}v1/auth/public/otp/verify';
    Map map = {
      "langCode": "en",
      "data": {"key": mobile, "code": code}
    };
    List<int> body = utf8.encode(json.encode(map));
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.contentLengthHeader: body.length.toString(),
        },
        body: body);
    if (response.statusCode == 200) {
      print("Verificaton code");
      print(json.decode(response.body));
      if (json.decode(response.body)['status'] == 500) {
        return -1;
      }
      return json.decode(response.body)['data'];
    }
    return -1;
  }

  // Fetch Business Provinence list from get site states api
  Future<void> fetchStateList() async {
    final String url =
        '${GlobalConfiguration().getString('api_base_url')}v1/common/public/sites/states/all';

    Map map = {"langCode": "en", "data": 2};
    List<int> body = utf8.encode(json.encode(map));

    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.contentLengthHeader: body.length.toString(),
      },
      body: body,
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data']);
      var values = json.decode(response.body)['data'];
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            setState(() {
              stateList.add(map);
            });
          }
        }
      }
      print("State List");
      print(stateList);
    }
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
        );
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }
}
