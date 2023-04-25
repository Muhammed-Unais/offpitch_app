import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/save_continue_button.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_checkbox.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_first_fields.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_image_filed.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_second_field.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_tabbar.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_third_fieds.dart';
import 'package:offpitch_app/view_model/create_tournament_view_model.dart';
import 'package:offpitch_app/view_model/services.dart/tournament_creation_validation/tournamen_creation_validation.dart';
import 'package:provider/provider.dart';

class CreateTournamentView extends StatefulWidget {
  const CreateTournamentView({super.key});

  @override
  State<CreateTournamentView> createState() => _CreateTournamentViewState();
}

class _CreateTournamentViewState extends State<CreateTournamentView>
    with TickerProviderStateMixin {
  late TabController tabController;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => CreateTournamentViewModel(),
      child: Consumer<CreateTournamentViewModel>(builder: (context, value, _) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Host Tournament",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(
                  60,
                ),
                child: CreateTournamentViewTabbar(tabController: tabController),
              ),
            ),
            body: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CreateTournamentImagefield(
                          border: value.border,
                        ),
                        const CreateTournamentfirstFields(
                          dateValidator:
                              TournamentCreationValidation.dateValidator,
                          locationValidator:
                              TournamentCreationValidation.locationValidator,
                          titleValidator:
                              TournamentCreationValidation.titleValidator,
                          descValidator:
                              TournamentCreationValidation.descriptionValidator,
                          aboutValidator:
                              TournamentCreationValidation.aboutValidator,
                        ),
                        SaveContinueButton(
                          width: size.width * 0.4,
                          btnFunction: () {
                            value.images == null
                                ? value.setBorderError(
                                    Border.all(color: Colors.red))
                                : null;
                            if (formKey.currentState!.validate() &&
                                value.images != null) {
                              tabController.animateTo(tabController.index + 1);
                            }
                          },
                          text: "Save & Continue",
                        )
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                    key: formKey1,
                    child: Column(
                      children: [
                        const CreateTournamentSecondFields(
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
                        const CreateTournamentCheckbox(
                          amoutFeesValidator:
                              TournamentCreationValidation.amountValidator,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Back",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SaveContinueButton(
                              width: size.width * 0.4,
                              btnFunction: () {
                                if (formKey1.currentState!.validate()) {
                                  tabController
                                      .animateTo(tabController.index + 1);
                                }
                              },
                              text: "Save & continue",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
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
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
