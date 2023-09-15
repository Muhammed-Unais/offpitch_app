import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/bottom_bar_view/view_model/bottom_bar_viewmodel.dart';
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
            "Registred Tournaments",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          InkWell(
            onTap: () {
              context.read<BottomBarViewModel>().onTap(1, context);
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
