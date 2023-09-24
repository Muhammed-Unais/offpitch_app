import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:readmore/readmore.dart';

class DetailsViewShortDescription extends StatelessWidget {
  const DetailsViewShortDescription(
      {super.key, required this.shortDescription});

  final String? shortDescription;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ReadMoreText(
        shortDescription ?? "",
        trimLines: 6,
        colorClickableText: AppColors.primary,
        trimMode: TrimMode.Line,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: "Lato",
          color: AppColors.black,
         
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
