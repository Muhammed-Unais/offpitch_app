import 'package:flutter/material.dart';

import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard(
      {super.key,
      required this.touranmentCoverImage,
      required this.tornamentName,
      required this.tornamentPlace,
      required this.tornamentDate,
       this.shortDescription});

  final String touranmentCoverImage;
  final String tornamentName;
  final String tornamentPlace;
  final String tornamentDate;
  final String? shortDescription;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: AppMargin.large,
            right: AppMargin.large,
            top: AppMargin.small,
            bottom: AppMargin.small,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
              AppRadius.borderRadiusM,
            ),
          ),
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.15,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        AppRadius.borderRadiusM,
                      ),
                      topRight: Radius.circular(
                        AppRadius.borderRadiusM,
                      ),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        touranmentCoverImage,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppPadding.small),
                  height: size.height * 0.1,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        AppRadius.borderRadiusM,
                      ),
                      bottomRight: Radius.circular(
                        AppRadius.borderRadiusM,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tornamentName,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                          ),
                          Text(
                            tornamentPlace,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                            width: AppMargin.extraSmall,
                          ),
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 16,
                          ),
                          Text(
                            tornamentDate.toString(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Text(
                        shortDescription ??"",
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: size.width / 2 - 40,
          child: Container(
            height: 24,
            width: 80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
              color: AppColors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  AppRadius.borderRadiusM,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                (tornamentDate),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        )
      ],
    );
  }

  // String tournamentStand(startDate) {
  //   DateTime now = DateTime.now();
  //   DateTime date = DateTime(now.year, now.month, now.day);
  //   DateTime tournamentStartingDate =
  //       DateFormat("dd MMM yyyy").parse(startDate);
  //   int difference = date.compareTo(tournamentStartingDate);
  //   if (difference < 0) {
  //     return "Upcoming";
  //   } else if (difference == 0) {
  //     return "Live";
  //   } else {
  //     return "Results";
  //   }
  // }
}
