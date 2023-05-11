
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_first_fields.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_image_filed.dart';
import 'package:offpitch_app/view_model/create_tournament_view_model/create_tournament_view_model.dart';
import 'package:offpitch_app/view_model/services.dart/tournament_creation_validation/tournamen_creation_validation.dart';

class CreateTournamentTabOne extends StatelessWidget {
  const CreateTournamentTabOne(
      {super.key,
      required this.controller,
      required this.value,
      required this.tabController,
      required this.formKey,
      });

  final ScrollController controller;
  final CreateTournamentViewModel value;
  final TabController tabController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: controller,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CreateTournamentImagefield(
                  border: value.border,
                ),
                const CreateTournamentfirstFields(
                  dateValidator: TournamentCreationValidation.dateValidator,
                  locationValidator:
                      TournamentCreationValidation.locationValidator,
                  titleValidator: TournamentCreationValidation.titleValidator,
                  descValidator:
                      TournamentCreationValidation.descriptionValidator,
                  aboutValidator: TournamentCreationValidation.aboutValidator,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: AppMargin.large,
          right: AppMargin.large,
          child: Visibility(
            visible: value.isVisible,
            child: FloatingActionButton(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              onPressed: () {
                value.images == null
                    ? value.setBorderError(
                        Border.all(color: Colors.red),
                      )
                    : null;
                if (formKey.currentState!.validate() && value.images != null) {
                  tabController.animateTo(tabController.index + 1);
                  value.testValue = tabController.index + 1;
                }
              },
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        )
      ],
    );
  }
}
