import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class MatchesResultCards extends StatelessWidget {
  const MatchesResultCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
         color: AppColors.white,
         boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(
              0.5,
            ),
            blurRadius: 7,
            offset: const Offset(
              0,
              3,
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.only(
          top: AppMargin.large,left: AppMargin.large,right: AppMargin.large),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text("Match 1", style: Theme.of(context).textTheme.titleMedium),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/images/pexels-francesco-paggiaro-705794.jpg"),
                      radius: 30,
                    ),
                    const SizedBox(height: 8),
                    Text("firstTeamName",
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              Flexible(child: Text('2 - 4', style: Theme.of(context).textTheme.titleLarge)),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/images/pexels-francesco-paggiaro-705794.jpg"),
                      radius: 30,
                    ),
                    const SizedBox(height: 8),
                    Text("secondTeamName",
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
