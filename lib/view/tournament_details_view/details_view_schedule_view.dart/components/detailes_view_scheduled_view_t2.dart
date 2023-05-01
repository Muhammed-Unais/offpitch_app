import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/components/matches_result_cards.dart';
import 'package:offpitch_app/res/constats.dart';

class DetailsViewscheduledviewT2 extends StatelessWidget {
  const DetailsViewscheduledviewT2(
      {super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppRadius.borderRadiusS,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      singleTournamentModel.data!.cover!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                singleTournamentModel.data!.title!,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
        const SizedBox(
          height: AppMargin.large,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppMargin.large),
          child: Divider(
            thickness: 0.5,
            color: AppColors.grey,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppMargin.large),
                  child: Text(
                    "Final",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                ListView.builder(
                  physics:const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return const MatchesResultCards();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
