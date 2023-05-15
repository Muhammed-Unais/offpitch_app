import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:readmore/readmore.dart';

class DetailsViewShortDescription extends StatelessWidget {
  const DetailsViewShortDescription({super.key, required this.shortDescription});

  final String? shortDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.large,
        vertical: AppMargin.medium,
      ),
      child: ReadMoreText(
        shortDescription ?? "",
        trimLines: 6,
        colorClickableText: AppColors.primary,
        trimMode: TrimMode.Line,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
