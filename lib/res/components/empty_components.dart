import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/res/constats.dart';

class EmptyComponts extends StatelessWidget {
  const EmptyComponts(
      {super.key, required this.image, required this.showMessage, required this.height, required this.width, required this.addText});

  final String image;
  final String showMessage;
  final double height;
  final double width;
  final String addText;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.small),
          height: height,
          width: width,
          child: SvgPicture.asset(
            image,
          ),
        ),
        Text.rich(
          TextSpan(
           text: showMessage ,
           style: Theme.of(context).textTheme.titleMedium,
           children: [
            const TextSpan(
              text: ' '
            ),
             TextSpan(
              text: addText,
              style: Theme.of(context).textTheme.labelMedium
             )
           ]
          )
        ),
      ],
    );
  }
}
