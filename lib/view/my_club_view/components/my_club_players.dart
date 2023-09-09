import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/players_card.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_add_player_bottom_sheet.dart';
import 'package:offpitch_app/view/my_club_view/model/players_model.dart';
import 'package:offpitch_app/view/my_club_view/view_model/my_club_over_view_model.dart';
import 'package:provider/provider.dart';

class MyClubPlayers extends StatelessWidget {
  const MyClubPlayers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: AppMargin.large),
      child: Consumer<MyClubViewModel>(
        builder: (context, value, _) {
          switch (value.getPlayerapiResponse.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              );
            case Status.COMPLETED:
        
              final data = value.getPlayerapiResponse.data!.data!;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length + 1,
                itemBuilder: (context, index) {
                  Datum? player;
                  if (index != 0) {
                    player = data[index - 1];
                  }
                  return index == 0
                      ? AddPlayerCard(
                          buttonAction: () {
                            AddPlayerBottomSheet.showBottomAddPlayer(context);
                          },
                        )
                      : PlayersCard(
                          dob: player?.dateOfBirth,
                          image: player?.profile,
                          playerName: player?.name,
                        );
                },
              );
            case Status.ERROR:
              return Center(
                child: ErrorComponent(
                  errorMessage: value.getPlayerapiResponse.message!,
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
