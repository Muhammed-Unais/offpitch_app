import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view/home_view.dart';
import 'package:offpitch_app/view/login_view/login_view.dart';
import 'package:offpitch_app/view/otp_verify_view.dart';
import 'package:offpitch_app/view/signup_view/signup_view.dart';
import 'package:offpitch_app/view/splash_view.dart';

class Routes {
  static Route<dynamic> genericRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (context) => const SignupView(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RoutesName.otp:
        return MaterialPageRoute(
          builder: (context) => const OtpVerifyView(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text(
                "No route defined",
              ),
            ),
          ),
        );
    }
  }
}
