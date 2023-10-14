import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/src/tournament_details_view/components/all_body_content_widget.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/src/details_view_schedule_view.dart/view/scheduled_view.dart';
import 'package:offpitch_app/src/tournament_details_view/view_model/tournament_detils_view_model.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AllBodyContentWidget(
                  data: data,
                  size: size,
                  teams: teams,
                  singleTournamentModel:
                      tournametnDetailProvider.detailsTournament.data,
                ),
              );
            }
          case Status.ERROR:
            return Center(
              child: ErrorComponent(
                hight: size.height * 0.15,
                width: size.height * 0.15,
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
