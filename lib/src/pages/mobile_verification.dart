import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:string_validator/string_validator.dart';
import '../controllers/customer_controller.dart';
import '../repository/customer_repository.dart' as repo;

import '../helpers/app_config.dart' as config;
import '../models/route_argument.dart';

class MobileVerification extends StatefulWidget {
  RouteArgument routeArgument;
  MobileVerification({Key key, this.routeArgument}) : super(key: key);
  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends StateMVC<MobileVerification> {
  CustomerController _con;

  bool _isLoadingState = false;
  bool isLoadingState = false;
  String _wrong = "";
  String _optCode = "";

  _MobileVerificationState() : super(CustomerController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String currentText = "";
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
      body: Container(
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
                "Mobile Verification Required",
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            SizedBox(
              height: config.App(context).appHeight(1.5),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: config.App(context).appWidth(5),
              ),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "We`ve SMS a code to the following mobile number ",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  TextSpan(
                    text: widget.routeArgument.param != null
                        ? widget.routeArgument.param
                        : '',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: " Please enter the code below:",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: config.App(context).appHeight(4),
            ),
            Form(
              key: _con.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: config.App(context).appWidth(18),
                ),
                child: PinCodeTextField(
                  validator: (String value) {
                    if (isNull(value)) {
                      return "Opt verification code id required";
                    } else if (!isNumeric(value)) {
                      return "Code must be numbers only, min 4 max 4";
                    } else if (!isLength(value, 4, 4)) {
                      return "Code must be numbers only, min 4 max 4";
                    } else
                      return null;
                  },
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    inactiveColor: config.Colors().mainDarkColor(1),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  cursorColor: config.Colors().mainDarkColor(1),
                  animationDuration: Duration(milliseconds: 300),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  keyboardAppearance: Brightness.light,
                  autoDismissKeyboard: false,
                  onCompleted: (v) {
                    print("Completed");
                    setState(() {
                      _optCode = v;
                    });
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: config.App(context).appHeight(6),
              child: Center(
                child: Text(
                  _wrong,
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).accentColor),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _isLoadingState = true;
                });
                _con.sendOTP(widget.routeArgument.param).then((phone) {
                  setState(() {
                    _isLoadingState = false;
                  });
                });
              },
              child: _isLoadingState == false
                  ? RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Didn`t receive a code? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: config.Colors().mainDarkColor(1),
                            ),
                          ),
                          TextSpan(
                            text: " Resend",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    ),
            ),
            SizedBox(
              height: config.App(context).appHeight(0.7),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "The verification code is valid for ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: config.Colors().mainDarkColor(1),
                  ),
                ),
                TextSpan(
                  text: " 15 minutes",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().mainDarkColor(1),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: config.App(context).appHeight(4),
            ),
            ButtonTheme(
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
                      _con
                          .sendVerificationCode(
                              widget.routeArgument.param, _optCode)
                          .then((code) {
                        if (code != -1) {
                          setState(() {
                            _wrong = "";
                            repo.customer.code = code;
                          });

                          Navigator.of(context).pushReplacementNamed(
                            '/BusinessInformation',
                            arguments: RouteArgument(
                                param: widget.routeArgument.param),
                          );
                        } else {
                          setState(() {
                            isLoadingState = false;
                            _wrong = "Opt verification code is wrong";
                          });
                        }
                      });
                    } else {
                      setState(() {
                        isLoadingState = false;
                      });
                    }
                  },
                  child: isLoadingState == false
                      ? Text(
                          "Confirm",
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
          ],
        ),
      ),
    );
  }
}
