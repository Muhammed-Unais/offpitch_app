import 'package:flutter/material.dart';
import 'package:offpitch_app/src/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/matches_result_cards.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/src/details_view_schedule_view.dart/components/scheduled_view_alert_dialge.dart';
import 'package:offpitch_app/src/splash_screen/view_model/user_view_model.dart';
import 'package:offpitch_app/src/details_view_schedule_view.dart/view_model/schedule_tournament_view_model.dart';
import 'package:provider/provider.dart';

class KnockOutTournamentT2 extends StatelessWidget {
  const KnockOutTournamentT2({super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: tournamentProfileandTitle(size),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Divider(
            thickness: 0.5,
            color: AppColors.grey,
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: singleTournamentModel.data?.matches?.rounds?.length,
            itemBuilder: (context, index) {
              final roundData =
                  singleTournamentModel.data?.matches?.rounds?[index];
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: roundData?.matches?.length,
                    itemBuilder: (context, index1) {
                      final teamAGoal =
                          roundData?.matches?[index1].teamA?.goals;
                      final teamBGoal =
                          roundData?.matches?[index1].teamB?.goals;
                      final match = roundData?.matches?[index1];
                      return GestureDetector(
                        onTap: teamAGoal == null ||
                                teamBGoal == null ||
                                teamAGoal >= 0 && teamBGoal >= 0
                            ? null
                            : () {
                                final values = ScheduleTournametViewModel();
                                Team? teamA = roundData?.matches?[index1].teamA;
                                Team? teamB = roundData?.matches?[index1].teamB;

                                var singleTournament =
                                    singleTournamentModel.data;

                                final myClubId =
                                    context.read<UserViewModel>().userClubId;

                                if (myClubId == singleTournament?.host?.id) {
                                  Utils.showDialogue(
                                    context,
                                    child: CustomAlertDialog(
                                      tournamentId: singleTournament?.id,
                                      matchNo: match?.matchNo,
                                      roundNo: roundData?.roundNo,
                                      team1Name:
                                          values.setFirstLetterofClubTeamA(
                                              teamA?.name),
                                      team2Name:
                                          values.setFirstLetterofClubTeamB(
                                              teamB?.name),
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
          ),
        ),
      ],
    );
  }

  Row tournamentProfileandTitle(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
          width: size.width * 0.2,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppRadius.borderRadiusS,
            ),
            image: DecorationImage(
              image: NetworkImage(
                singleTournamentModel.data?.cover ?? AppProfilesCover.clubCover,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          singleTournamentModel.data?.title ?? "",
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
