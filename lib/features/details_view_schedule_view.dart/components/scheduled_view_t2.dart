import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/matches_result_cards.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/scheduled_view_alert_dialge.dart';
import 'package:offpitch_app/features/splash_screen/view_model/user_view_model.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/view_model/schedule_tournament_view_model.dart';
import 'package:provider/provider.dart';

class ScheduledviewT2 extends StatelessWidget {
  const ScheduledviewT2({super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: tournamentProfileandTitle(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppMargin.large,
            vertical: AppMargin.small,
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
                      horizontal: AppMargin.large,
                    ),
                    child: Text(
                      roundData?.name ?? "",
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
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
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: roundData?.matches?.length,
                      itemBuilder: (context, index1) {
                        final teamAGoal =
                            roundData?.matches?[index1].teamA?.goals;
                        final teamBGoal =
                            roundData?.matches?[index1].teamB?.goals;
                        return InkWell(
                          onTap: teamAGoal == null ||
                                  teamBGoal == null ||
                                  teamAGoal >= 0 && teamBGoal >= 0
                              ? null
                              : () {
                                  final values = ScheduleTournametViewModel();
                                  String? teamA =
                                      roundData?.matches?[index1].teamA?.name;
                                  String? teamB =
                                      roundData?.matches?[index1].teamB?.name;

                                  // match Score updating show dialog=======
                                  final myClubId = Provider.of<UserViewModel>(
                                          context,
                                          listen: false)
                                      .userClubId;
                                  if (myClubId ==
                                      singleTournamentModel.data?.host?.id) {
                                    Utils.showDialogue(
                                      context,
                                      child: CustomAlertDialog(
                                        tournamentId:
                                            singleTournamentModel.data?.id,
                                        matchNo:
                                            roundData?.matches?[index1].matchNo,
                                        roundNo: roundData?.roundNo,
                                        team1Name: values
                                            .setFirstLetterofClubTeamA(teamA),
                                        team2Name: values
                                            .setFirstLetterofClubTeamB(teamB),
                                        team1cover: roundData
                                            ?.matches?[index1].teamA?.profile,
                                        team2cover: roundData
                                            ?.matches?[index1].teamB?.profile,
                                      ),
                                    );
                                  }
                                },
                          child: MatchesResultCards(
                            matchNo: roundData?.matches?[index1].matchNo,
                            team1Cover:
                                roundData?.matches?[index1].teamA?.profile,
                            team2Cover:
                                roundData?.matches?[index1].teamB?.profile,
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
          ),
        ),
      ],
    );
  }

  Row tournamentProfileandTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
          width: 80,
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
