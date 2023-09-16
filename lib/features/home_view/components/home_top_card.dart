import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/features/home_view/components/home_carousels.dart';
import 'package:offpitch_app/features/home_view/view_model/home_view_model.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';
import '../../explore_view/model/all_tournaments_model.dart';

class HomeTopCard extends StatefulWidget {
  const HomeTopCard({super.key});

  @override
  State<HomeTopCard> createState() => _HomeTopCardState();
}

class _HomeTopCardState extends State<HomeTopCard> {
  @override
  void initState() {
    var homeProvider = context.read<HomeViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider.apiResponse?.data ?? homeProvider.getAllTournaments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, _) {
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
            switch (homeViewModel.apiResponse!.status) {
              case Status.LOADING:
                return index == 1
                    ? const HomeTournametnCard()
                    : const SizedBox();

              case Status.COMPLETED:
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
              case Status.ERROR:
                return index == 0
                    ? const HomeTournametnCard()
                    : Center(
                        child: Text(
                          homeViewModel.apiResponse!.message.toString(),
                        ),
                      );

              default:
                return const SizedBox();
            }
          },
        );
      },
    );
  }
}
