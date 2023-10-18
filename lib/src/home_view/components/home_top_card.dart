import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/src/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/src/home_view/components/home_tournament_default_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/src/home_view/components/home_carousels.dart';
import 'package:offpitch_app/src/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';
import '../../explore_view/model/all_tournaments_model.dart';

class HomeNewTornamentCards extends StatelessWidget {
  const HomeNewTornamentCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreViewViewModel>(
      builder: (context, exploreProvider, _) {
        int length = 0;
        switch (exploreProvider.allTournaments.status) {
          case Status.LOADING:
            return const Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: HomeTournametnCard(
                reduceWidth: 0,
              ),
            );

          case Status.COMPLETED:
            if (exploreProvider.allTournaments.data!.length > 4) {
              length = 4;
            } else {
              length = exploreProvider.allTournaments.data!.length;
            }
            
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              itemCount: length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                AllTournament? data;
                if (index != 0) {
                  data = exploreProvider.allTournaments.data?.reversed
                      .toList()[index - 1];
                }
                return index == 0
                    ? const HomeTournametnCard()
                    : GestureDetector(
                        onTap: () async {
                          context
                              .read<DetailsTouramentViewModel>()
                              .getSingleTournament(data?.id);
                          await Navigator.pushNamed(
                              context, RoutesName.tournamentDetails);
                        },
                        child: HomeCarousels(
                          location: data?.location ?? "",
                          dateAndTime: data?.startDate ?? "",
                          tournamentName: data?.title ?? "",
                          image: data?.cover ?? AppProfilesCover.clubCover,
                        ),
                      );
              },
            );

          case Status.ERROR:
            return const Padding(
              padding: EdgeInsets.only(left: 20, right: 9),
              child: HomeTournametnCard(
                reduceWidth: 0,
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
