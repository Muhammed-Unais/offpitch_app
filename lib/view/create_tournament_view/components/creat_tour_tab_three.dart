import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/save_continue_button.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_third_fieds.dart';
import 'package:offpitch_app/view_model/create_tournament_view_model/create_tournament_view_model.dart';

class CreatTournamentTabThree extends StatelessWidget {
  const CreatTournamentTabThree({super.key, required this.value});

  final CreateTournamentViewModel value;

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
            Text(
              "Back",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SaveContinueButton(
              isloading: value.isLoading!,
              width: size.width * 0.4,
              btnFunction: () {
                if (value.isCheckTourType1 != null ||
                    value.isCheckTourType2 != null ||
                    value.isCheckTourType3 != null) {
                  value.submitButtonTourCreate(context);
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
