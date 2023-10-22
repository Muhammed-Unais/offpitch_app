import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/create_tournament_view/components/creat_tour_checkbox.dart';
import 'package:offpitch_app/src/create_tournament_view/components/creat_tour_second_field.dart';
import 'package:offpitch_app/src/create_tournament_view/view_model/create_tournament_view_model.dart';
import 'package:offpitch_app/res/common/services.dart/tournament_creation_validation/tournamen_creation_validation.dart';

class CreatTournamentTabTwo extends StatelessWidget {
  const CreatTournamentTabTwo({
    super.key,
    required this.tabController,
    required this.formKey1,
    required this.value,
  });

  final TabController tabController;
  final GlobalKey<FormState> formKey1;
  final CreateTournamentViewModel value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Form(
            key: formKey1,
            child: const Column(
              children: [
                CreateTournamentSecondFields(
                  instructionValidator:
                      TournamentCreationValidation.instructionValidator,
                  maxNoOfRegValidator:
                      TournamentCreationValidation.maxNoOfRegValidator,
                  lastDateRegValidator:
                      TournamentCreationValidation.lastdateRegValidator,
                  minOfPlayersValidator:
                      TournamentCreationValidation.minNoOfPlayers,
                  maxNoOfPlayersValidator:
                      TournamentCreationValidation.maxNoOfPlayers,
                ),
                CreateTournamentCheckbox(
                  amoutFeesValidator:
                      TournamentCreationValidation.amountValidator,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: AppMargin.large,
          right: AppMargin.large,
          child: FloatingActionButton(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            onPressed: () {
              if (formKey1.currentState!.validate()) {
                tabController.animateTo(tabController.index + 1);
              }
            },
            child: const Icon(Icons.arrow_forward_ios),
          ),
        )
      ],
    );
  }
}
