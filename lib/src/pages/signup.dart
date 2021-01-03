import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:string_validator/string_validator.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:global_configuration/global_configuration.dart';

import '../controllers/customer_controller.dart';
import '../repository/customer_repository.dart' as repo;
import '../helpers/app_config.dart' as config;
import '../models/route_argument.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends StateMVC<SignUpWidget> {
  CustomerController _con;
  bool isLoadingState = false;

  _SignUpWidgetState() : super(CustomerController()) {
    _con = controller;
  }

  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _phoneCodeController =
      new TextEditingController();
  final TextEditingController _mobileNoController = new TextEditingController();

  bool isConfirmed = true;
  bool isSubscribe = false;

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  void _togglePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleConfirmPassword() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
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
                  key: _con.formKey,
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
                      SizedBox(height: config.App(context).appHeight(1.2)),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => repo.customer.firstName = input,
                        validator: (String value) {
                          if (isNull(value)) {
                            return "First name is required";
                          } else if (!isLength(value, 2, 20) ||
                              !isAlpha(value)) {
                            return "First name must be alphabet only, min 2 max 20";
                          } else
                            return null;
                        },
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
                          errorStyle: TextStyle(height: 0.4),
                        ),
                      ),
                      SizedBox(height: config.App(context).appHeight(1.2)),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => repo.customer.lastName = input,
                        validator: (String value) {
                          if (isNull(value)) {
                            return "Last name is required";
                          } else if (!isLength(value, 2, 20) ||
                              !isAlpha(value)) {
                            return "Last name must be alphabet only, min 2 max 20";
                          } else
                            return null;
                        },
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
                          errorStyle: TextStyle(height: 0.4),
                        ),
                      ),
                      SizedBox(height: config.App(context).appHeight(1.2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: config.App(context).appWidth(35),
                              child: DropdownButtonFormField(
                                validator: (String value) {
                                  if (isNull(value))
                                    return "Phone code is required";
                                  else
                                    return null;
                                },
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: _con.phoneCodeList
                                    .map(
                                      (code) => DropdownMenuItem(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: config.App(context)
                                                .appWidth(10),
                                          ),
                                          child: Text(
                                            code,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display2,
                                          ),
                                        ),
                                        value: code.toString(),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _phoneCodeController.text = val;
                                  });
                                },
                                onSaved: (input) =>
                                    repo.customer.phoneCode = input,
                                decoration: InputDecoration(
                                  hintStyle:
                                      Theme.of(context).textTheme.display1,
                                  prefixIcon: Icon(
                                    Icons.phone_iphone,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minHeight: 25,
                                    minWidth: 25,
                                  ),
                                  errorStyle: TextStyle(height: 0.4),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: _mobileNoController,
                              keyboardType: TextInputType.phone,
                              onSaved: (input) =>
                                  repo.customer.mobileNo = input,
                              validator: (String value) {
                                if (isNull(value)) {
                                  return "Mobile number is required";
                                } else if (!isNumeric(value)) {
                                  return "Mobile must be numeric only";
                                } else if (!isLength(value, 9, 10)) {
                                  return "Mobile must be min 9, max 10";
                                } else if (_con.isUnique == false) {
                                  return "Mobile number already registered";
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Mobile Number",
                                hintStyle: Theme.of(context).textTheme.display1,
                                errorStyle: TextStyle(height: 0.4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: config.App(context).appHeight(1.2)),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureTextPassword,
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (input) {
                          repo.customer.password = input;
                        },
                        validator: (String value) {
                          if (isNull(value)) {
                            return "Password is required";
                          } else if (!isLength(value, 8, 20)) {
                            return "Password must be min 8, max 20";
                          } else
                            return null;
                        },
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye_outlined,
                              color: _obscureTextPassword
                                  ? Theme.of(context).hintColor
                                  : Theme.of(context).focusColor,
                            ),
                            onPressed: _togglePassword,
                          ),
                          errorStyle: TextStyle(height: 0.4),
                        ),
                      ),
                      SizedBox(height: config.App(context).appHeight(1.2)),
                      TextFormField(
                        obscureText: _obscureTextConfirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        onSaved: (input) {
                          repo.customer.confirmPassword = input;
                        },
                        validator: (String value) {
                          if (isNull(value)) {
                            return "Confirm password is required";
                          } else if (!isLength(value, 8, 20)) {
                            return "Confirm password must be min 8, max 20";
                          } else if (!equals(value, _passwordController.text)) {
                            return "Password does not match";
                          } else
                            return null;
                        },
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye_outlined,
                              color: _obscureTextConfirmPassword
                                  ? Theme.of(context).hintColor
                                  : Theme.of(context).focusColor,
                            ),
                            onPressed: _toggleConfirmPassword,
                          ),
                          errorStyle: TextStyle(height: 0.4),
                        ),
                      ),
                      SizedBox(height: config.App(context).appHeight(1.2)),
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
                            child: InkWell(
                              onTap: () async {
                                if (await canLaunch(
                                    '${GlobalConfiguration().getString('base_url')}termsandconditions.html')) {
                                  await launch(
                                      '${GlobalConfiguration().getString('base_url')}termsandconditions.html');
                                }
                              },
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
                          ),
                        ],
                      ),
                      SizedBox(height: config.App(context).appHeight(1.2)),
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
                      SizedBox(height: config.App(context).appHeight(1.2)),
                      ButtonTheme(
                        minWidth: config.App(context).appWidth(90),
                        height: config.App(context).appHeight(6),
                        child: RaisedButton(
                          onPressed: () async {
                            setState(() {
                              isLoadingState = true;
                              repo.customer.subscribeNewsLetter = isSubscribe;
                            });
                            await _con.isMobileUnique(
                                _phoneCodeController.text +
                                    _mobileNoController.text);
                            print(
                                "phone: ${_phoneCodeController.text + _mobileNoController.text}");
                            print("isUnique: +${_con.isUnique}");

                            if (_con.formKey.currentState.validate() &&
                                isConfirmed == true) {
                              _con.formKey.currentState.save();
                              _con
                                  .sendOTP(_phoneCodeController.text +
                                      _mobileNoController.text)
                                  .then((phone) {
                                if (phone != null) {
                                  Navigator.of(context).pushReplacementNamed(
                                      '/MobileVerification',
                                      arguments: RouteArgument(param: phone));
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
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
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
                      SizedBox(height: config.App(context).appHeight(0.5)),
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
              bottom: 5,
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
