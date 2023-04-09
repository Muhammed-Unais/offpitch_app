import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view/home_view/components/home_top_card.dart';
import 'package:offpitch_app/view_model/home_view_model.dart';
import 'package:offpitch_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  HomeViewModel homeViewModel = HomeViewModel();
  @override
  void initState() {
    homeViewModel.getAllTournaments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    style: Theme.of(context).iconButtonTheme.style,
                    padding: const EdgeInsets.only(
                      left: AppMargin.large,
                    ),
                    onPressed: () {
                      userViewModel.remove();
                    },
                    icon: const Icon(
                      color: AppColors.white,
                      Icons.menu,
                    ),
                  ),
                  IconButton(
                    splashRadius: 0.1,
                    style: Theme.of(context).iconButtonTheme.style,
                    padding: const EdgeInsets.only(
                      right: AppMargin.large,
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      color: AppColors.white,
                      Icons.notifications_none_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: size.height,
                  margin: const EdgeInsets.only(
                    top: AppMargin.extraLarge * 5,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        AppRadius.borderRadiusL,
                      ),
                      topRight: Radius.circular(
                        AppRadius.borderRadiusL,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: size.height / 11),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.large,
                            vertical: AppPadding.extraSmall),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Upcoming",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "See All",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ChangeNotifierProvider<HomeViewModel>(
                          create: (context) => homeViewModel,
                          child: Consumer<HomeViewModel>(
                            builder: (context, value, _) {
                              return ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  switch (value.allTournamentModel.status) {
                                    case Status.LOADING:
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    case Status.ERROR:
                                      return Utils.showFlushbarErrorMessage(
                                          message:
                                              value.allTournamentModel.message!,
                                          isError: true);
                                    case Status.COMPLETED:
                                      return TournamentCard(
                                        shortDescription: value
                                            .allTournamentModel
                                            .data!
                                            .data
                                            .allTournaments[index]
                                            .shortDescription,
                                        tornamentDate: value
                                            .allTournamentModel
                                            .data!
                                            .data
                                            .allTournaments[index].startDate,
                                        tornamentName: value
                                            .allTournamentModel
                                            .data!
                                            .data
                                            .allTournaments[index].title,
                                        tornamentPlace: value
                                            .allTournamentModel
                                            .data!
                                            .data
                                            .allTournaments[index].location,
                                        touranmentCoverImage: value
                                            .allTournamentModel
                                            .data!
                                            .data
                                            .allTournaments[index]
                                            .cover,
                                      );
                                    default:
                                      return const CircularProgressIndicator();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const HomeTopCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
