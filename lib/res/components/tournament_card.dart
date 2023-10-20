import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard(
      {super.key,
      required this.coverUrl,
      required this.tornamentName,
      required this.tornamentPlace,
      required this.tornamentDate,
      this.shortDescription,
      this.isDiscription = true,
      this.status});

  final String? coverUrl;
  final String tornamentName;
  final String tornamentPlace;
  final String tornamentDate;
  final String? shortDescription;
  final String? status;
  final bool isDiscription;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromRGBO(228, 229, 229, 1), width: 1),
            color: AppColors.white,
            borderRadius: BorderRadius.circular(
              AppRadius.borderRadiusS,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    coverUrl == null
                        ? const CircleAvatar(
                            backgroundColor: AppColors.white,
                            backgroundImage:
                                AssetImage(AppProfilesCover.tournamentCover),
                            maxRadius: 36,
                          )
                        : ClipOval(
                            child: FadeInImage(
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.cover,
                              placeholder: const AssetImage(
                                AppProfilesCover.tournamentCover,
                              ),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppProfilesCover.tournamentCover,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholderErrorBuilder:
                                  (context, error, stackTrace) {
                                return Image.asset(
                                  AppProfilesCover.tournamentCover,
                                  height: 60,
                                  width: 60,
                                );
                              },
                              image: NetworkImage(
                                coverUrl!,
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tornamentName,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                tornamentDate.toString(),
                                style: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 12,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.location_on_outlined,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                tornamentPlace,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Lato",
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      shortDescription ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "SFUIDisplay",
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
