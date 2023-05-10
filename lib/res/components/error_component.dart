import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/res/styles/constats.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.small),
          height: 150,
          width: 150,
          child: SvgPicture.asset(
            "assets/images/no-data.svg",
          ),
        ),
        Text(errorMessage),
      ],
    );
  }
}
