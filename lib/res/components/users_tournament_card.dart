import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/styles/constats.dart';

class UsersTournametCard extends StatelessWidget {
  const UsersTournametCard(
      {super.key,
      this.image,
      this.tournamentName,
      this.tournamentPlace,
      this.tournamentDate,
      this.tournamentRegTeams, this.isUserHost =true, this.paymentStatus});

  final String? image;
  final String? tournamentName;
  final String? tournamentPlace;
  final String? tournamentDate;
  final int? tournamentRegTeams;
  final bool isUserHost;
  final String? paymentStatus; 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(
          left: AppMargin.large, right: AppMargin.large, top: AppMargin.medium),
      decoration: BoxDecoration(
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
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusS,
        ),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                    AppRadius.borderRadiusS,
                  ),
                  topLeft: Radius.circular(
                    AppRadius.borderRadiusS,
                  ),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    image ??
                        "https://res.cloudinary.com/dvihywo6p/image/upload/v1682693289/naw24ko7p7j1enbjkc8d.jpg",
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Container(
              padding: const EdgeInsetsDirectional.all(AppPadding.medium),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(
                    AppRadius.borderRadiusS,
                  ),
                  topRight: Radius.circular(
                    AppRadius.borderRadiusS,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      tournamentName ?? "",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              const Flexible(
                                child: Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                ),
                              ),
                              Flexible(
                                flex: 6,
                                child: Text(
                                  tournamentPlace ?? "",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              const Flexible(
                                child: SizedBox(
                                  width: AppMargin.extraSmall,
                                ),
                              ),
                              const Flexible(
                                child: Icon(
                                  Icons.calendar_month_outlined,
                                  size: 16,
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Text(
                                  tournamentDate ?? "",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      isUserHost?
                      "$tournamentRegTeams Registered":"Payment Status $paymentStatus",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
