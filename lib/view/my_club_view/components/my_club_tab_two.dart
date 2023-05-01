import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/models/user_host_tournament_model.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/tabbar_my_club_view.dart';
import 'package:offpitch_app/res/components/users_tournament_card.dart';
import 'package:offpitch_app/view_model/my_club_user_host_tournament_view_model.dart';
import 'package:provider/provider.dart';

class MyClubTabTwo extends StatefulWidget {
  const MyClubTabTwo({super.key});

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
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          TabbarMyClubView(
            tabController: tabController,
            tabbar1: "Upcoming",
            tabbar2: "Live",
            tabbar3: "Ended",
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: TabBarView(
              controller: tabController,
              children: [
                Consumer<UserHostedTournamentViewModel>(
                  builder: (context, value, _) {
                    switch (value.apiResponse.status) {
                      case Status.LOADING:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case Status.COMPLETED:
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.apiResponse.data!.length,
                          itemBuilder: (context, index) {
                            final data = value.apiResponse.data!.reversed
                                .toList()[index];
                                return UsersTournametCard(
                                  image: data.cover,
                                  tournamentName: data.title,
                                  tournamentPlace: data.location,
                                  tournamentDate: data.startDate.toString(),
                                  tournamentRegTeams: data.teamsCount,
                                );
                          },
                        );
                      case Status.ERROR:
                        return ErrorComponent(
                          errorMessage: value.apiResponse.message!,
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                ),
                const Text("ss"),
                const Text("sss"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
