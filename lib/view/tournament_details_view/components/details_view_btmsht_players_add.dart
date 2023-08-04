
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/registration_view_model.dart';
import 'package:provider/provider.dart';

class DetailsViewBtmShtPlayersAdd extends StatelessWidget {
  const DetailsViewBtmShtPlayersAdd({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 200.0,
      child: Consumer<MyClubViewModel>(
        builder: (context, myclubView, _) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: myclubView.getPlayerapiResponse.data?.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final data = myclubView.getPlayerapiResponse.data?.data;
              return Container(
                height: 160,
                width: 140,
                margin: const EdgeInsets.only(right: AppMargin.small),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    colorFilter: const ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                    image: NetworkImage(data?[index].profile ?? ""),
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
                                data?[index].name ?? "",
                                style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                'Age: ${registrViewModel.dobToAge(data?[index].dateOfBirth ?? DateTime.now())}',
                                style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Checkbox(
                        fillColor: MaterialStatePropertyAll(
                          Colors.white.withOpacity(0.5),
                        ),
                        activeColor: AppColors.white,
                        checkColor: AppColors.primary,
                        value: myclubView.selectedPlayers[index],
                        onChanged: (bool? valu) {
                          registrViewModel.playersAddingcheckbox(
                              valu!, index, context);
                          if (valu &&
                              !registrViewModel.playersIds
                                  .contains(data?[index].id)) {
                            registrViewModel.playersIds
                                .add(data?[index].id ?? "");
                          } else if (!valu) {
                            registrViewModel.playersIds.removeWhere(
                              (element) => element == data?[index].id,
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
