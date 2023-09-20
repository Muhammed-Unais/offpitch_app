import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/features/home_view/components/home_tournament_default_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/features/home_view/components/home_carousels.dart';
import 'package:offpitch_app/features/home_view/view_model/home_view_model.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';
import '../../explore_view/model/all_tournaments_model.dart';

class HomeNewTornamentCards extends StatefulWidget {
  const HomeNewTornamentCards({super.key});

  @override
  State<HomeNewTornamentCards> createState() => _HomeNewTornamentCardsState();
}

class _HomeNewTornamentCardsState extends State<HomeNewTornamentCards> {
  late HomeViewModel homeProvider;
  @override
  void initState() {
    homeProvider = context.read<HomeViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider.apiResponse?.data ?? homeProvider.getAllTournaments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, _) {
        switch (homeViewModel.apiResponse!.status) {
          case Status.LOADING:
            return const Padding(
              padding: EdgeInsets.only(left: 20,right: 10),
              child: HomeTournametnCard(
                reduceWidth: 0,
              ),
            );

          case Status.COMPLETED:
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              itemCount: homeViewModel.count + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                AllTournament? data;
                if (index != 0) {
                  data = homeViewModel
                      .apiResponse?.data?.data?.allTournaments?.reversed
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
                padding: EdgeInsets.only(left: 20,right: 9),
              child: HomeTournametnCard(reduceWidth: 0,),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
