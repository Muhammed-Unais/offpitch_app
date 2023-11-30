import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/save_continue_button.dart';
import 'package:offpitch_app/src/create_tournament/components/creat_tour_third_fieds.dart';
import 'package:offpitch_app/src/create_tournament/view_model/create_tournament_view_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class CreatTournamentTabThree extends StatelessWidget {
  const CreatTournamentTabThree(
      {super.key, required this.value, required this.tabController});

  final CreateTournamentViewModel value;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CreateTournamentThirdFields(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                tabController.animateTo(1);
              },
              child: const Text(
                "Back",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            SaveContinueButton(
              isloading: value.isLoading!,
              width: size.width * 0.4,
              btnFunction: () async {
                if (value.isCheckTourType1 != null ||
                    value.isCheckTourType2 != null ||
                    value.isCheckTourType3 != null) {
                  await value.submitButtonTournamentCreate(context);
                }
              },
              text: "Submit",
            ),
          ],
        )
      ],
    );
  }
}
