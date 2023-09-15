import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/create_tournament_view/components/creat_tour_first_fields.dart';
import 'package:offpitch_app/features/create_tournament_view/components/creat_tour_image_filed.dart';
import 'package:offpitch_app/features/create_tournament_view/view_model/create_tournament_view_model.dart';
import 'package:offpitch_app/res/common/services.dart/tournament_creation_validation/tournamen_creation_validation.dart';

class CreateTournamentTabOne extends StatelessWidget {
  const CreateTournamentTabOne({
    super.key,
    required this.controller,
    required this.value,
    required this.tabController,
    required this.formKey,
    required this.isVisible,
  });

  final ScrollController controller;
  final CreateTournamentViewModel value;
  final TabController tabController;
  final GlobalKey<FormState> formKey;
  final bool isVisible;

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
            visible: isVisible,
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
                  tabController.animateTo(1);
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
