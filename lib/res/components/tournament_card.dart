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
      this.shortDescription,
      this.isDiscription = true,
      this.status});

  final String touranmentCoverImage;
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
                    CircleAvatar(
                      backgroundColor: AppColors.white,
                      backgroundImage: NetworkImage(touranmentCoverImage),
                      maxRadius: 36,
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
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
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
                                  fontFamily: "SFUIDisplay",
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
                                  fontFamily: "SFUIDisplay",
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
