
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/components/matches_result_cards.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view/tournament_details_view/details_view_schedule_view.dart/components/scheduled_view_alert_dialge.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/schedule_tournament_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class ScheduleViewT1MatchTab extends StatelessWidget {
  const ScheduleViewT1MatchTab(
      {super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: singleTournamentModel.data?.matches?.rounds?.length,
      itemBuilder: (context, index) {
        final roundData = singleTournamentModel.data?.matches?.rounds?[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppMargin.large,
              ),
              child: Text(
                roundData?.name ?? "",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: AppColors.black,
                  width: 0.1,
                ),
              ),
              margin: const EdgeInsets.only(
                top: AppMargin.small,
                left: AppMargin.large,
                right: AppMargin.large,
                bottom: AppMargin.small,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: roundData?.matches?.length,
                itemBuilder: (context, index1) {
                  final teamAGoal = roundData?.matches?[index1].teamA?.goals;
                  final teamBGoal = roundData?.matches?[index1].teamB?.goals;
                  return InkWell(
                    onTap: teamAGoal! >= 0 || teamBGoal! >= 0
                        ? null
                        : () {
                            final values = ScheduleTournametViewModel();
                            String? teamA = roundData?.matches?[index1].teamA?.name;
                            String? teamB = roundData?.matches?[index1].teamB?.name;

                            // match Score updating show dialog=======
                            final myClubId =
                                Provider.of<DetailsTouramentViewModel>(context,
                                        listen: false)
                                    .myClubId;
                            if (myClubId ==
                                singleTournamentModel.data?.host?.id) {
                              Utils.showDialogue(
                                context,
                                child: CustomAlertDialog(
                                  tournamentId: singleTournamentModel.data?.id,
                                  matchNo: roundData?.matches?[index1].matchNo,
                                  roundNo: roundData?.roundNo,
                                  team1Name:
                                      values.setFirstLetterofClubTeamA(teamA),
                                  team2Name:
                                      values.setFirstLetterofClubTeamB(teamB),
                                  team1cover:
                                      roundData?.matches?[index1].teamA?.profile,
                                  team2cover:
                                      roundData?.matches?[index1].teamB?.profile,
                                ),
                              );
                            }
                          },
                    child: MatchesResultCards(
                      matchNo: roundData?.matches?[index1].matchNo,
                      team1Cover: roundData?.matches?[index1].teamA?.profile,
                      team2Cover: roundData?.matches?[index1].teamB?.profile,
                      team1Name: roundData?.matches?[index1].teamA?.name,
                      team2Name: roundData?.matches?[index1].teamB?.name,
                      team1Goal: roundData?.matches?[index1].teamA?.goals,
                      team2Goal: roundData?.matches?[index1].teamB?.goals,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppMargin.medium,
            )
          ],
        );
      },
    );
  }
}
