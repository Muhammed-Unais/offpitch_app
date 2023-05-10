import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/view/home_view/components/home_top_card.dart';
import 'package:offpitch_app/view/home_view/components/home_topbar.dart';
import 'package:offpitch_app/view/home_view/components/home_upconing_tites.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/home_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          // homw top icon and iconbutton
          const HommeTopBar(),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: size.height,
                  margin: const EdgeInsets.only(
                    top: AppMargin.extraLarge * 5,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        AppRadius.borderRadiusL,
                      ),
                      topRight: Radius.circular(
                        AppRadius.borderRadiusL,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: size.height / 11),
                      // home upcoming title
                      const HomeUpcomingtitle(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: AppMargin.small,
                              ),
                              Consumer<HomeAndExpViewModel>(
                                builder: (context, value, _) {
                                  switch (value.allTournamentModel.status) {
                                    case Status.LOADING:
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppMargin.large,
                                        ),
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return ShimerWidget.rectangular(
                                            borderRadius:
                                                AppRadius.borderRadiusM,
                                            verticalMargin: AppMargin.small,
                                            hight: size.height * 0.2,
                                          );
                                        },
                                      );
                                    case Status.ERROR:
                                      log(value.allTournamentModel.message
                                          .toString());
                                      return Center(
                                        child: ErrorComponent(
                                          errorMessage: value
                                                  .allTournamentModel.message ??
                                              "",
                                        ),
                                      );
                                    case Status.COMPLETED:
                                      final data = value.allTournamentModel.data
                                          ?.data.allTournaments;
                                      if (data ==null ||data.isEmpty) {
                                        return const EmptyComponts(
                                          addText: "",
                                          height: 200,
                                          width: 200,
                                          showMessage: "No Tournaments",
                                          image: "assets/images/no-data.svg",
                                        );
                                      }
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          final values =data
                                              .reversed
                                              .toList()[index];
                                          return InkWell(
                                            onTap: () async {
                                              final provider = Provider.of<
                                                      DetailsTouramentViewModel>(
                                                  context,
                                                  listen: false);
                                              provider.getSingleTournament(
                                                  values.id);
                                              await Navigator.pushNamed(
                                                  context, "tournamentdetails");
                                            },
                                            child: TournamentCard(
                                              shortDescription:
                                                  values.shortDescription,
                                              tornamentDate: values.startDate,
                                              tornamentName: values.title,
                                              tornamentPlace: values.location,
                                              touranmentCoverImage:
                                                  values.cover,
                                            ),
                                          );
                                        },
                                      );
                                    default:
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const HomeTopCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
