import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helpers/app_config.dart' as config;

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends StateMVC<SignUpWidget> {
  bool isConfirmed = true;
  bool isSubscribe = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: null,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: config.App(context).appHeight(10),
              child: SvgPicture.asset(
                'assets/img/logo.svg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(17),
              child: Container(
                width: config.App(context).appWidth(90),
                child: Form(
                  key: null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Get Started",
                        style: Theme.of(context).textTheme.display4,
                      ),
                      SizedBox(height: config.App(context).appHeight(1)),
                      Text(
                        "Create an account",
                        style: Theme.of(context).textTheme.display2,
                      ),
                      SizedBox(height: config.App(context).appHeight(1.5)),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "First Name",
                          hintStyle: Theme.of(context).textTheme.display1,
                          prefixIcon: Tab(
                            icon: SvgPicture.asset(
                              "assets/img/person_circle_outlined.svg",
                              width: 17,
                              height: 17,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minHeight: 25,
                            minWidth: 25,
                          ),
                        ),
                      ),
                      SizedBox(height: config.App(context).appHeight(1.5)),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Last Name",
                          hintStyle: Theme.of(context).textTheme.display1,
                          prefixIcon: Tab(
                            icon: SvgPicture.asset(
                              "assets/img/person_circle_outlined.svg",
                              width: 17,
                              height: 17,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minHeight: 25,
                            minWidth: 25,
                          ),
                        ),
                      ),
                      SizedBox(height: config.App(context).appHeight(1.5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: config.App(context).appWidth(35),
                              child: DropdownButtonFormField(
                                hint: Icon(
                                  Icons.phone_iphone,
                                  color: Theme.of(context).hintColor,
                                ),
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: [],
                                onChanged: (val) => print(val),
                                onSaved: (val) => print(val),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: "Mobile Number",
                                hintStyle: Theme.of(context).textTheme.display1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: config.App(context).appHeight(1.5)),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: Theme.of(context).textTheme.display1,
                            prefixIcon: Tab(
                              icon: Icon(Icons.lock_outline),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                      ),
                      SizedBox(height: config.App(context).appHeight(1.5)),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            hintStyle: Theme.of(context).textTheme.display1,
                            prefixIcon: Tab(
                              icon: Icon(Icons.lock_outline),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 25,
                              minWidth: 25,
                            ),
                            suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                      ),
                      SizedBox(height: config.App(context).appHeight(1.5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Switch(
                            value: isConfirmed,
                            onChanged: (value) {
                              setState(() {
                                isConfirmed = value;
                              });
                            },
                            activeTrackColor: Theme.of(context).primaryColor,
                            activeColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "I confirm that I`ve read and agree on Tawreed",
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                  TextSpan(
                                    text: " Terms and condition",
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.4,
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: config.App(context).appHeight(1.5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Switch(
                            value: isSubscribe,
                            onChanged: (value) {
                              setState(() {
                                isSubscribe = value;
                              });
                            },
                            activeTrackColor: Theme.of(context).primaryColor,
                            activeColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Subscribe to Tawrid newsletter",
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: config.App(context).appHeight(1.5)),
                      ButtonTheme(
                        minWidth: config.App(context).appWidth(90),
                        height: config.App(context).appHeight(6),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                                '/MobileVerification',
                                arguments: 2);
                          },
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(height: config.App(context).appHeight(1.5)),
                      FlatButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Tab(
                              icon: SvgPicture.asset(
                                "assets/img/global.svg",
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Switch language to: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " العربية",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: FlatButton(
                  onPressed: () {},
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Already have an account?",
                          style: Theme.of(context).textTheme.display2,
                        ),
                        TextSpan(
                          text: "  Sign in",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
