import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../helpers/app_config.dart' as config;

class MobileVerification extends StatefulWidget {
  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/SignUp');
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
                    text: "00971567895944",
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
              key: null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: config.App(context).appWidth(14),
                ),
                child: PinCodeTextField(
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
            ),
            FlatButton(
              onPressed: () {},
              child: RichText(
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
                    Navigator.of(context).pushReplacementNamed(
                        '/BusinessInformation',
                        arguments: 2);
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
