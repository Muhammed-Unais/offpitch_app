import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupTopimage extends StatelessWidget {
  const SignupTopimage({super.key});

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SvgPicture.asset(
      'assets/images/signup svg.svg',
      height: hight * .3,
      width: width * .25,
    );
  }
}