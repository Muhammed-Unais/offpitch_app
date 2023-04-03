import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/view_model/services.dart/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    splashServices.checkAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Spacer(flex: 2),
          Expanded(
            flex: 6,
            child: Center(
              child: SvgPicture.asset(
                "assets/images/Offpitch_logo.svg",
              ),
            ),
          ),
          const Spacer(flex: 2,)
        ],
      ),
    );
  }
}
