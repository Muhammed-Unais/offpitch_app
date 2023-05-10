import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class UserProfileAboutUsExpansion extends StatelessWidget {
  const UserProfileAboutUsExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      title: Text("About Us", style: Theme.of(context).textTheme.labelLarge),
      children: const [],
    );
  }
}
