import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class RegisteredTeams extends StatelessWidget {
  const RegisteredTeams({super.key, this.singleTourdata});

  final SingleTournamentModel? singleTourdata;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Registered teams",
                style: TextStyle(
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 12,
                ),
              ),
              Text(
                singleTourdata?.data?.teams?.length.toString() ?? 0.toString(),
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: singleTourdata?.data?.teams?.length ?? 0,
              itemBuilder: (context, index) {
                var data = singleTourdata?.data?.teams;
                return Card(
                  elevation: 0,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.black, width: 0.5),
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
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                  fontFamily: "Lato",
                                ),
                              ),
                              Text(
                                "Players:${data?[index].players?.length ?? 0}",
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                  fontFamily: "Lato",
                                ),
                              )
                            ],
                          ),
                        )
                      ],
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
