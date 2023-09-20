import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/checkboxs.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/create_tournament_view/view_model/create_tournament_view_model.dart';
import 'package:provider/provider.dart';

class CreateTournamentThirdFields extends StatelessWidget {
  const CreateTournamentThirdFields({super.key});

  @override
  Widget build(BuildContext context) {
    var tourCreateViewModel = context.watch<CreateTournamentViewModel>();
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.large, vertical: AppMargin.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tournament type:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            overflow: TextOverflow.ellipsis,
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
              const Text(
                "LEAGUE\n(Round robin tournament)",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const Divider(color: AppColors.grey, thickness: 0.5),
          Row(
            children: [
              CheckBoxs(
                isCheck: tourCreateViewModel.isCheckTourType2,
                function: (value) {
                  tourCreateViewModel.setIsCheckTourTypeTwo(value);
                },
              ),
              const Text(
                "KNOCK OUT\n(Elimination tournament)",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.grey, thickness: 0.5),
        ],
      ),
    );
  }
}
