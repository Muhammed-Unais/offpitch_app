import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/tabbar_my_club_view.dart';
import 'package:offpitch_app/res/components/users_tournament_card.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/features/my_club_view/view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class MyClubTabTwo extends StatefulWidget {
  const MyClubTabTwo({
    super.key,
    this.userClubId,
  });

  final String? userClubId;

  @override
  State<MyClubTabTwo> createState() => _MyClubTabTwoState();
}

class _MyClubTabTwoState extends State<MyClubTabTwo>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabbarMyClubView(
          tabController: tabController,
          tabbar1: "Upcoming",
          tabbar2: "Live",
          tabbar3: "Ended",
        ),
        Expanded(
          child: widget.userClubId != null && widget.userClubId!.isNotEmpty
              ? TabBarView(
                  controller: tabController,
                  children: [
                    Consumer<UserHostRegTournamentViewModel>(
                      builder: (context, value, _) {
                        switch (value.apiResponseHostedTournaments.status) {
                          case Status.LOADING:
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primary,
                              ),
                            );
                          case Status.COMPLETED:
                            if (value.apiResponseHostedTournaments.data ==
                                    null ||
                                value.apiResponseHostedTournaments.data!
                                    .isEmpty) {
                              return const EmptyComponts(
                                image: "assets/images/no-data.svg",
                                showMessage: "No Tournaments",
                                height: 150,
                                width: 150,
                                addText: "Host Tournaments",
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: value
                                  .apiResponseHostedTournaments.data?.length,
                              itemBuilder: (context, index) {
                                final data = value
                                    .apiResponseHostedTournaments.data!.reversed
                                    .toList()[index];
                                return InkWell(
                                  onTap: () async {
                                    context
                                        .read<DetailsTouramentViewModel>()
                                        .getSingleTournament(data.id);
                                    await Navigator.pushNamed(
                                        context, "tournamentdetails");
                                  },
                                  child: UsersTournametCard(
                                    image: data.cover,
                                    tournamentName: data.title,
                                    tournamentPlace: data.location,
                                    tournamentDate: data.startDate.toString(),
                                    tournamentRegTeams: data.teamsCount,
                                  ),
                                );
                              },
                            );
                          case Status.ERROR:
                            return ErrorComponent(
                              errorMessage:
                                  value.apiResponseHostedTournaments.message!,
                            );
                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                    const Text(""),
                    const Text(""),
                  ],
                )
              : InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.clubCreation);
                  },
                  child: const EmptyComponts(
                    image: "assets/images/no-club.svg",
                    showMessage: "You Don't have a club",
                    height: 200,
                    width: 200,
                    addText: "Create new",
                  ),
                ),
        )
      ],
    );
  }
}
