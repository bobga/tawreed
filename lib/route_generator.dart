import 'package:flutter/material.dart';
import 'src/pages/signup.dart';
import 'src/pages/splash_screen.dart';
import 'src/pages/mobile_verification.dart';
import 'src/pages/business_information.dart';
import 'src/pages/confirm_signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/MobileVerification':
        return MaterialPageRoute(builder: (_) => MobileVerification());
      case '/BusinessInformation':
        return MaterialPageRoute(builder: (_) => BusinessInformation());
      case '/ConfirmSignUp':
        return MaterialPageRoute(builder: (_) => ConfirmSingUp());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
