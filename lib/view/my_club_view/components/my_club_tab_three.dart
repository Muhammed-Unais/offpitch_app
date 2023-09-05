import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/tabbar_my_club_view.dart';
import 'package:offpitch_app/res/components/users_tournament_card.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view_model/my_club_view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class MyClubTabThree extends StatefulWidget {
  const MyClubTabThree({super.key, this.userClubId});

  final String? userClubId;

  @override
  State<MyClubTabThree> createState() => _MyClubTabThreeState();
}

class _MyClubTabThreeState extends State<MyClubTabThree>
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
                        switch (value.apiResponseRegisTournaments.status) {
                          case Status.LOADING:
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primary,
                              ),
                            );
                          case Status.COMPLETED:
                            if (value.apiResponseRegisTournaments.data ==
                                    null ||
                                value.apiResponseRegisTournaments.data!
                                    .isEmpty) {
                              return const EmptyComponts(
                                image: "assets/images/no-data.svg",
                                showMessage: "No Tournaments",
                                height: 150,
                                width: 150,
                                addText: "Registor...",
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: value
                                  .apiResponseRegisTournaments.data!.length,
                              itemBuilder: (context, index) {
                                final data = value
                                    .apiResponseRegisTournaments.data!.reversed
                                    .toList()[index];
                                return InkWell(
                                  onTap: () async {
                                    final provider = context
                                        .read<DetailsTouramentViewModel>();
                                    provider.getSingleTournament(data.id);
                                    await Navigator.pushNamed(
                                      context,
                                      "tournamentdetails",
                                    );
                                  },
                                  child: UsersTournametCard(
                                    image: data.cover,
                                    tournamentName: data.title,
                                    tournamentPlace: data.location,
                                    tournamentDate: data.startDate.toString(),
                                    isUserHost: false,
                                    paymentStatus: data.teams!.status,
                                  ),
                                );
                              },
                            );
                          case Status.ERROR:
                            return ErrorComponent(
                              errorMessage:
                                  value.apiResponseRegisTournaments.message!,
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
        ),
      ],
    );
  }
}
