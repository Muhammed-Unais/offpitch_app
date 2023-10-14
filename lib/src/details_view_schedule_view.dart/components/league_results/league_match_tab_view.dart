import 'package:flutter/material.dart';
import 'package:offpitch_app/src/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/components/matches_result_cards.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/src/details_view_schedule_view.dart/components/scheduled_view_alert_dialge.dart';
import 'package:offpitch_app/src/splash_screen/view_model/user_view_model.dart';
import 'package:offpitch_app/src/details_view_schedule_view.dart/view_model/schedule_tournament_view_model.dart';
import 'package:provider/provider.dart';

class LeagueMatchTabView extends StatelessWidget {
  const LeagueMatchTabView({super.key, required this.singleTournamentModel});

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
                horizontal: 20,
              ),
              child: Text(
                roundData?.name ?? "",
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: roundData?.matches?.length,
              itemBuilder: (context, index1) {
                final teamAGoal = roundData?.matches?[index1].teamA?.goals;
                final teamBGoal = roundData?.matches?[index1].teamB?.goals;
                final match = roundData?.matches?[index1];
                return GestureDetector(
                  onTap: teamAGoal! >= 0 || teamBGoal! >= 0
                      ? null
                      : () {
                          final values = ScheduleTournametViewModel();
                          var teamA = roundData?.matches?[index1].teamA;
                          var teamB = roundData?.matches?[index1].teamB;

                          final myClubId =
                              context.read<UserViewModel>().userClubId;

                          if (myClubId ==
                              singleTournamentModel.data?.host?.id) {
                            Utils.showDialogue(
                              context,
                              child: CustomAlertDialog(
                                tournamentId: singleTournamentModel.data?.id,
                                matchNo: match?.matchNo,
                                roundNo: roundData?.roundNo,
                                team1Name: values
                                    .setFirstLetterofClubTeamA(teamA?.name),
                                team2Name: values
                                    .setFirstLetterofClubTeamB(teamB?.name),
                                team1cover: teamA?.profile,
                                team2cover: teamB?.profile,
                              ),
                            );
                          }
                        },
                  child: MatchesResultCards(
                    matchNo: match?.matchNo,
                    team1Cover: match?.teamA?.profile,
                    team2Cover: match?.teamB?.profile,
                    team1Name: match?.teamA?.name,
                    team2Name: match?.teamB?.name,
                    team1Goal: match?.teamA?.goals,
                    team2Goal: match?.teamB?.goals,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }
}
