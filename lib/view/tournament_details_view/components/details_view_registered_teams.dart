import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_registered_temas.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class RegisteredTeams extends StatelessWidget {
  const RegisteredTeams({super.key, this.singleTourdata});

  final SingleTournamentModel? singleTourdata;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      height: 180,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Registered teams",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                singleTourdata?.data?.teams?.length.toString() ?? 0.toString(),
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          const SizedBox(
            height: AppMargin.medium,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: singleTourdata?.data?.teams?.length ?? 0,
              itemBuilder: (context, index) {
                final data = singleTourdata?.data?.teams;
                return InkWell(
                  onTap: () {
                    // bottom naigatin bar for user can see the club details
                    Provider.of<DetailsTouramentViewModel>(context,listen: false)
                        .getRegisterdClubdetails(
                            singleTourdata?.data?.id, data?[index].id);
                    Utils.showDialogue(
                      context,
                      child: const DetailsViewRegisteredTeams(),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(color: AppColors.black, width: 0.5),
                      borderRadius:
                          BorderRadius.circular(AppRadius.borderRadiusS),
                    ),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  AppRadius.borderRadiusS,
                                ),
                                topRight: Radius.circular(
                                  AppRadius.borderRadiusS,
                                ),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(data?[index].profile ??
                                    AppProfilesCover.clubCover),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  AppRadius.borderRadiusS,
                                ),
                                bottomRight:
                                    Radius.circular(AppRadius.borderRadiusS),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  data?[index].name ?? "No title",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "Players:${data?[index].players?.length ?? 0}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
