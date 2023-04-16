import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';

class HomeUpcomingtitle extends StatelessWidget {
  const HomeUpcomingtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.large, vertical: AppPadding.extraSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "All Tournaments",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "explore");
            },
            child: Text(
              "See All",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
