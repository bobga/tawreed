import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'route_generator.dart';
import 'src/helpers/app_config.dart' as config;
import 'src/controllers/controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  runApp(MyApp());
}

class MyApp extends AppMVC {
  // This widget is the root of your application.

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) {
        return ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: config.Colors().mainColor(1),
          primaryColor: config.Colors().secondColor(1),
          accentColor: config.Colors().accentColor(1),
          focusColor: config.Colors().focusColor(1),
          hintColor: config.Colors().secondDarkColor(1),
          textTheme: TextTheme(
            headline: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().mainDarkColor(1)),
            display1: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                color: config.Colors().secondDarkColor(1)),
            display2: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: config.Colors().mainDarkColor(1)),
            display3: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().mainDarkColor(1)),
            display4: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().mainDarkColor(1)),
            title: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: config.Colors().mainDarkColor(1)),
            body1: TextStyle(
                fontSize: 15.0, color: config.Colors().mainDarkColor(1)),
            body2: TextStyle(
                fontSize: 14.0, color: config.Colors().mainDarkColor(1)),
            caption: TextStyle(
                fontSize: 12.0, color: config.Colors().mainDarkColor(0.6)),
          ),
        );
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          initialRoute: '/Splash',
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          theme: theme,
        );
      },
    );
  }
}
