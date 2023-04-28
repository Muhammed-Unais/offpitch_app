import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/models/players_model.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/players_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_add_player_bottom_sheet.dart';
import 'package:offpitch_app/view_model/my_club_view_model.dart';
import 'package:provider/provider.dart';

class MyClubPlayers extends StatelessWidget {
  const MyClubPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    List<bool> isAddPlayer = [true];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      height: 250,
      child: Consumer<MyClubViewModel>(
        builder: (context, value, _) {
          switch (value.getPlayerapiResponse.status) {
            case Status.LOADING:
              return const CircularProgressIndicator();
            case Status.COMPLETED:
              final data = value.getPlayerapiResponse.data!.data!;
              log("Count:${value.count.toString()}");
              if (value.count == 0) {
                data.insert(0, Datum());
                value.count++;
              }
              // log(data.length.toString());
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if (isAddPlayer.length < data.length) {
                    isAddPlayer.add(false);
                  }
                  log(isAddPlayer.length.toString());
                  return PlayersCard(
                    dob: data[index].dateOfBirth,
                    buttonAction: () {
                      AddPlayerBottomSheet.showBottomAddPlayer(
                        context,
                      );
                    },
                    image: data[index].profile,
                    isAddplayer: isAddPlayer[index],
                    playerName: data[index].name,
                  );
                },
              );
            case Status.ERROR:
              return ErrorComponent(
                errorMessage: value.getPlayerapiResponse.message!,
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
