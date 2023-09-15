import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:readmore/readmore.dart';

class TabViewOneClubDescription extends StatelessWidget {
  const TabViewOneClubDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.grey, width: 0.2),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ReadMoreText(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
              trimMode: TrimMode.Line,
              trimLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}
