import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/tournament_details_view/components/details_view_about.dart';
import 'package:offpitch_app/features/tournament_details_view/components/details_view_club_name.dart';
import 'package:offpitch_app/features/tournament_details_view/components/details_view_data_place.dart';
import 'package:offpitch_app/features/tournament_details_view/components/details_view_register.dart';
import 'package:offpitch_app/features/tournament_details_view/components/details_view_registered_teams.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/scheduled_view.dart';
import 'package:offpitch_app/features/tournament_details_view/components/details_view_short_description.dart';
import 'package:offpitch_app/features/tournament_details_view/components/details_view_tournament_image.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<DetailsTouramentViewModel>(
      builder: (context, tournametnDetailProvider, _) {
        switch (tournametnDetailProvider.detailsTournament.status) {
          case Status.LOADING:
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2.0,
              ),
            );
          case Status.COMPLETED:
            var data = tournametnDetailProvider.detailsTournament.data?.data;
            final teams =
                tournametnDetailProvider.detailsTournament.data?.data?.teams;

            if (data?.registration?.status == "scheduled") {
              return ScheduledView(
                singleTournamentModel:
                    tournametnDetailProvider.detailsTournament.data!,
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.large),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    DetailsViewClubName(
                      clubImage:
                          data?.host?.profile ?? AppProfilesCover.clubCover,
                      clubName: data?.host?.name ?? "",
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppMargin.large,
                        ),
                        child: Text(
                          data?.title ?? "",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    DetailsViewTournamentImage(
                      image: data?.cover ?? AppProfilesCover.clubCover,
                      hight: size.height * 0.25,
                      width: size.width,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppPadding.medium),
                      child: DetailsViewShortDescription(
                        shortDescription: data?.shortDescription,
                      ),
                    ),
                    DetailsViewDateTime(
                      place: data?.location ?? "",
                      date: data?.startDate ?? "",
                      hight: 44,
                      width: 44,
                      dateIcon: Icons.calendar_month,
                      placeIcon: Icons.place_outlined,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppMargin.large,
                      ),
                      child: Divider(
                        thickness: 0.5,
                        color: AppColors.grey,
                      ),
                    ),
                    DetailsViewRegister(
                      data: tournametnDetailProvider.detailsTournament.data!,
                    ),
                    teams!.isEmpty
                        ? const EmptyComponentPng(
                            errorMessage: "No Registration",
                            imagePath: "assets/images/No data-cuate.png",
                            hight: 100,
                            width: 100,
                          )
                        : RegisteredTeams(
                            singleTourdata:
                                tournametnDetailProvider.detailsTournament.data,
                          ),
                    DetailsViewAbout(
                        data: tournametnDetailProvider.detailsTournament.data!),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: AppMargin.large,
                        horizontal: AppMargin.large,
                      ),
                      child: Column(
                        children: [
                          Text(
                            data?.host?.email ?? "",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            data?.host?.phone?.toString() ?? "",
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          case Status.ERROR:
            return Center(
              child: ErrorComponent(
                hight: size.height*0.15,
                width: size.height*0.15,
                errorMessage:
                    tournametnDetailProvider.detailsTournament.message!,
              ),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
