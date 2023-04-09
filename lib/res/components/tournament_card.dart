import 'package:flutter/material.dart';
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
    return Container(
      height: size.height / 4.95,
      width: size.width,
      margin: const EdgeInsets.symmetric(
        vertical: AppMargin.small,
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
                Spacer(),
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
                const Spacer(),
                Flexible(
                  flex: 4,
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
    );
  }
}
