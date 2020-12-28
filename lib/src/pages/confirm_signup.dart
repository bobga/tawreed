import 'package:flutter/material.dart';
import '../helpers/app_config.dart' as config;

class ConfirmSingUp extends StatefulWidget {
  @override
  _ConfirmSingUpState createState() => _ConfirmSingUpState();
}

class _ConfirmSingUpState extends State<ConfirmSingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: null,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Thank you for joining Tawreeed",
                    style: Theme.of(context).textTheme.display3,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: config.App(context).appWidth(5)),
                    child: Text(
                      "We`ve received your information. we will review them and get back to you shortly",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 16,
                        color: config.Colors().mainDarkColor(1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: ButtonTheme(
              minWidth: config.App(context).appWidth(90),
              height: config.App(context).appHeight(6),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: config.App(context).appWidth(5),
                ),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/SignUp', arguments: 2);
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
          ),
        ],
      ),
    );
  }
}
