import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:readmore/readmore.dart';

class DetailsViewAbout extends StatelessWidget {
  const DetailsViewAbout({super.key, required this.data});
  final SingleTournamentModel data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.large, vertical: AppMargin.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: AppMargin.small,
          ),
          ReadMoreText(
            data.data.description,
            style: Theme.of(context).textTheme.bodyLarge,
            trimMode: TrimMode.Line,
            trimLines: 10,
          )
        ],
      ),
    );
  }
}
