import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/schedule_tournament_view_model.dart';

class ScheduleViewT1TeamsTab extends StatelessWidget {
  const ScheduleViewT1TeamsTab(
      {super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: singleTournamentModel.data?.groups?.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                singleTournamentModel.data?.groups?[index].name ?? "Group -",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Team',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'MP',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'W',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'D',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'L',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'GF',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'GA',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'GD',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'PTS',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(color: AppColors.black,thickness: 0.2,);
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    singleTournamentModel.data?.groups?[index].teams?.length ??
                        0,
                itemBuilder: (BuildContext context, int index1) {
                  final data =
                      singleTournamentModel.data?.groups?[index].teams?[index1];
                  final values = ScheduleTournametViewModel();
                  return Container(
                    margin: const EdgeInsets.only(bottom: AppMargin.small),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Flexible(
                                child: CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  backgroundImage: NetworkImage(
                                    data?.profile == null ||
                                            data!.profile!.isEmpty
                                        ? 'https://www.gstatic.com/onebox/sports/logos/crest_48dp.png'
                                        : data.profile!,
                                  ),
                                  radius: 20.0,
                                ),
                              ),
                              const SizedBox(width: 2.0),
                              Flexible(
                                child: Text(
                                  values
                                          .setFirstLetterofClubTeamA(data?.name)
                                          ?.toUpperCase() ??
                                      "",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            data?.mp.toString() ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data?.w.toString() ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data?.d.toString() ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data?.l.toString() ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data?.gf.toString() ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data?.ga.toString() ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data?.gd.toString() ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            data?.pts.toString() ?? "",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
