import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/view_model/bottom_bar_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeUpcomingtitle extends StatelessWidget {
  const HomeUpcomingtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.large,
        vertical: AppPadding.extraSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "All Tournaments",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          InkWell(
            onTap: () {
              Provider.of<BottomBarViewModel>(context,listen: false).onTap(1, context);
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
