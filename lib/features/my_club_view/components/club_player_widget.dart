import 'package:flutter/material.dart';
import 'package:offpitch_app/features/my_club_view/components/my_club_players.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class ClubPlayerWidget extends StatelessWidget {
  const ClubPlayerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 10
            ),
            child: Text(
              "Club players",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          Flexible(
            child: MyClubPlayers(),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

