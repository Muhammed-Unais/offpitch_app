import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:readmore/readmore.dart';

class TournamentAboutWidget extends StatelessWidget {
  const TournamentAboutWidget({super.key, required this.data});
  final SingleTournamentModel data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About",
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppMargin.small,
          ),
          ReadMoreText(
            data.data?.description ?? "",
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontFamily: "Lato",
            ),
            trimMode: TrimMode.Line,
            trimLines: 10,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
