import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../helpers/app_config.dart' as config;

class BusinessInformation extends StatefulWidget {
  @override
  _BusinessInformationState createState() => _BusinessInformationState();
}

class _BusinessInformationState extends State<BusinessInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/MobileVerification');
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
                          height: config.App(context).appHeight(1.5),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
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
                          height: config.App(context).appHeight(1.5),
                        ),
                        DropdownButtonFormField(
                          hint: Row(
                            children: [
                              Icon(
                                Icons.phone_iphone,
                                size: 20,
                                color: Theme.of(context).hintColor,
                              ),
                              Text(
                                "Business Provinence",
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ],
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).hintColor,
                          ),
                          items: [],
                          onChanged: (val) => print(val),
                          onSaved: (val) => print(val),
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(1.5),
                        ),
                        TextFormField(
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
                          ),
                        ),
                        SizedBox(
                          height: config.App(context).appHeight(1.5),
                        ),
                        TextFormField(
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
                          height: config.App(context).appHeight(1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                        .pushReplacementNamed('/ConfirmSignUp', arguments: 2);
                  },
                  child: Text(
                    "Continue",
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
