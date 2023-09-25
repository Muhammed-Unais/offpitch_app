import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/my_club_view/view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/registration_view_model.dart';
import 'package:provider/provider.dart';

class RegistrationPlayersWidget extends StatelessWidget {
  const RegistrationPlayersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.0,
      child: Consumer<MyClubViewModel>(
        builder: (context, myclubView, _) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: myclubView.getPlayerapiResponse.data?.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final clubPlayers = myclubView.getPlayerapiResponse.data?.data;
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: AppMargin.small),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    colorFilter: const ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                    image: NetworkImage(clubPlayers?[index].profile ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Consumer<RegistorationViewModel>(
                    builder: (context, registrViewModel, _) {
                  return Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                clubPlayers?[index].name ?? "",
                                style: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 12,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                'Age: ${registrViewModel.dobToAge(clubPlayers?[index].dateOfBirth ?? DateTime.now())}',
                                style: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 12,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        fillColor: const MaterialStatePropertyAll(
                          Colors.white,
                        ),
                        activeColor: AppColors.white,
                        checkColor: AppColors.primary,
                        value: myclubView.selectedPlayers[index],
                        onChanged: (bool? valu) {
                          var selectedPlayer = registrViewModel.playersIds;

                          var clubPlayer = clubPlayers?[index];

                          registrViewModel.playersAddingcheckbox(
                              valu!, index, context);

                          if (valu &&
                              !selectedPlayer.contains(clubPlayer?.id)) {
                            selectedPlayer.add(clubPlayer?.id ?? "");

                          } else if (!valu) {
                            selectedPlayer.removeWhere(
                              (element) => element == clubPlayer?.id,
                            );
                          }
                        },
                      ),
                    ],
                  );
                }),
              );
            },
          );
        },
      ),
    );
  }
}
