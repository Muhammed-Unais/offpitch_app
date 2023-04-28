
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard(
      {super.key,
      required this.touranmentCoverImage,
      required this.tornamentName,
      required this.tornamentPlace,
      required this.tornamentDate,
      required this.shortDescription});

  final String touranmentCoverImage;
  final String tornamentName;
  final String tornamentPlace;
  final String tornamentDate;
  final String shortDescription;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height / 4.95,
          width: size.width,
          margin: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: AppMargin.large,
          ),
          decoration: BoxDecoration(
            border: Border.all(width: .5, color: AppColors.grey),
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
              AppRadius.borderRadiusM,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: size.height / 10,
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
                height: size.height / 10,
                width: size.width,
                decoration: const BoxDecoration(
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
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        tornamentName,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 3,
                      child: Row(
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
                            tornamentDate,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Flexible(
                      flex: 5,
                      child: Text(
                        shortDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                  color: Colors.grey.withOpacity(
                    0.5,
                  ),
                  blurRadius: 5,
                  offset: const Offset(
                    0,
                    0,
                  ),
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
                tournamentStand(tornamentDate),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        )
      ],
    );
  }

  String tournamentStand(startDate) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day -1);
    DateTime tournamentStartingDate =
        DateFormat("dd MMM yyyy").parse(startDate);
    int difference = date.compareTo(tournamentStartingDate);
    if (difference < 0) {
      // Tournament is before starting date
      return "Upcoming";
    } else if (difference == 0) {
      // Tournament is currently live
      return "Live";
    } else {
      // Tournament is after starting date
      return "Results";
    }
  }
}
