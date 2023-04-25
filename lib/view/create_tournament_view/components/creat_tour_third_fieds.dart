import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/components/checkboxs.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/create_tournament_view_model.dart';
import 'package:provider/provider.dart';

class CreateTournamentThirdFields extends StatelessWidget {
  const CreateTournamentThirdFields({super.key});

  @override
  Widget build(BuildContext context) {
    final tourCreateViewModel = Provider.of<CreateTournamentViewModel>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.large, vertical: AppMargin.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tournament type:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: AppMargin.large,
          ),
          Row(
            children: [
              CheckBoxs(
                isCheck: tourCreateViewModel.isCheckTourType1,
                function: (value) {
                  tourCreateViewModel.setIsCheckTourTypeOne(value);
                },
              ),
              Text(
                "League (Round robin tournament)",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const Divider(color: AppColors.grey),
          Row(
            children: [
              CheckBoxs(
                isCheck: tourCreateViewModel.isCheckTourType2,
                function: (value) {
                  tourCreateViewModel.setIsCheckTourTypeTwo(value);
                },
              ),
              Text(
                "Knock out (Elimination tournament)",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const Divider(color: AppColors.grey),
          Row(
            children: [
              CheckBoxs(
                isCheck: tourCreateViewModel.isCheckTourType3,
                function: (value) {
                  tourCreateViewModel.setIsCheckTourTypeThree(value);
                },
              ),
              Text(
                "Group Stage + Knockout",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const Divider(color: AppColors.grey),
        ],
      ),
    );
  }
}
