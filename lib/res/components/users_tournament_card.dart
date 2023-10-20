import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class UsersTournametCard extends StatelessWidget {
  const UsersTournametCard(
      {super.key,
      this.image,
      this.tournamentName,
      this.tournamentPlace,
      this.tournamentDate,
      this.tournamentRegTeams,
      this.isUserHost = true,
      this.paymentStatus});

  final String? image;
  final String? tournamentName;
  final String? tournamentPlace;
  final String? tournamentDate;
  final int? tournamentRegTeams;
  final bool isUserHost;
  final String? paymentStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: const Color.fromRGBO(228, 229, 229, 1),
          ),
          borderRadius: BorderRadius.circular(
            AppRadius.borderRadiusS,
          ),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: CachedNetworkImage(
                imageUrl: image!,
                imageBuilder: (context, imageProvider) {
                  return TournamentCover(
                    image: imageProvider,
                  );
                },
                placeholder: (context, url) => const SpinKitThreeBounce(
                  color: AppColors.primary,
                  size: 50,
                ),
                errorWidget: (context, url, error) => const TournamentCover(
                  image: AssetImage(
                    AppProfilesCover.tournamentCover,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Container(
                padding: const EdgeInsetsDirectional.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tournamentName ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                        ),
                        Text(
                          tournamentDate ?? "",
                          style: const TextStyle(
                            fontFamily: "Lato",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(
                          width: AppMargin.extraSmall,
                        ),
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                        ),
                        Text(
                          tournamentPlace ?? "",
                          style: const TextStyle(
                            fontFamily: "Lato",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      isUserHost
                          ? "$tournamentRegTeams Registered"
                          : "Payment Status $paymentStatus",
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TournamentCover extends StatelessWidget {
  const TournamentCover({
    super.key,
    required this.image,
  });

  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(
            AppRadius.borderRadiusS,
          ),
          topLeft: Radius.circular(
            AppRadius.borderRadiusS,
          ),
        ),
        image: DecorationImage(fit: BoxFit.cover, image: image),
      ),
    );
  }
}
