import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_about.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_club_name.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_data_place.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_register.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_registered_teams.dart';
import 'package:offpitch_app/view/tournament_details_view/details_view_schedule_view.dart/scheduled_view.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_short_description.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_tournament_image.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_tournament_name.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<DetailsTouramentViewModel>(
      builder: (context, value, _) {
        switch (value.detailsTournament.status) {
          case Status.LOADING:
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2.0,
              ),
            );
          case Status.COMPLETED:
            final data = value.detailsTournament.data?.data;
            if (data == null) {}
            //============== Scheduled to screen results======================
            if (data?.registration?.status == "scheduled") {
              return ScheduledView(
                singleTournamentModel: value.detailsTournament.data!,
              );
              // Details Screen Tournament closed without shedule  =============
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    DetailsViewClubName(
                      clubImage:
                          data?.host?.profile ?? AppProfilesCover.clubCover,
                      clubName: data?.host?.name ?? "",
                    ),
                    DetailsViewTournamentName(
                        tournamentName: data?.title ?? ""),
                    DetailsViewTournamentImage(
                      image: data?.cover ?? AppProfilesCover.clubCover,
                      hight: size.height * 0.25,
                      width: size.width,
                    ),
                    DetailsViewShortDescription(
                      shortDescription: data?.shortDescription,
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
                        horizontal: AppMargin.large,
                        vertical: AppMargin.large,
                      ),
                      child: Divider(
                        thickness: 0.5,
                        color: AppColors.grey,
                      ),
                    ),
                    // Registration components=======================
                    DetailsViewRegister(
                      data: value.detailsTournament.data!,
                    ),
                    // Registered Teams components====================
                    RegisteredTeams(
                      singleTourdata: value.detailsTournament.data,
                    ),
                    // about components ========================
                    DetailsViewAbout(data: value.detailsTournament.data!),
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
                errorMessage: value.detailsTournament.message!,
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
