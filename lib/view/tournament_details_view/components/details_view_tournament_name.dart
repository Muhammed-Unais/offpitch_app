import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/constats.dart';

class DetailsViewTournamentName extends StatelessWidget {
  const DetailsViewTournamentName({super.key, required this.tournamentName});

  final String tournamentName;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.large, vertical: AppMargin.large),
      child: Text(
        tournamentName,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
