import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/models/user_host_tournament_model.dart';
import 'package:offpitch_app/models/user_registered_model.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view/explore_view/components/explore_tabbar.dart';
import 'package:offpitch_app/view/home_view/components/home_top_card.dart';
import 'package:offpitch_app/view_model/bottom_bar_viewmodel.dart';
import 'package:offpitch_app/view_model/my_club_view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';
import '../../../view_model/my_club_view_model/my_club_over_view_model.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    fetchUserDetails();
    super.initState();
  }

  void fetchUserDetails() async {
    var homeProvider = context.read<UserHostRegTournamentViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider.apiResponseRegisTournaments.data ??
          homeProvider.getAllUserRegisteredTournaments();
      homeProvider.apiResponseHostedTournaments.data ??
          homeProvider.getAllUserHostedTournaments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          const SliverToBoxAdapter(
            child: ColoredBox(
              color: AppColors.white                                                                                                      ,
              child: HomeTopCard(),
            ),
          )
        ];
      },
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: allTournamentsDetails(size, context),
      ),
    );
  }

  Column allTournamentsDetails(Size size, BuildContext context) {
    return Column(
      children: [
        ExploreTabBar(
          tabController: tabController,
          firstTab: "Registred",
          secondTab: "Hosted",
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              registredTournaments(context, size),
              hostedTournaments(context, size)
            ],
          ),
        )
      ],
    );
  }

  Widget registredTournaments(BuildContext context, Size size) {
    return Consumer<UserHostRegTournamentViewModel>(
      builder: (context, usertournamentProvider, child) {
        switch (usertournamentProvider.apiResponseRegisTournaments.status) {
          case Status.LOADING:
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: AppMargin.large,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ShimerWidget.rectangular(
                  borderRadius: AppRadius.borderRadiusM,
                  verticalMargin: AppMargin.small,
                  hight: size.height * 0.2,
                );
              },
            );
          case Status.COMPLETED:
            if (usertournamentProvider.apiResponseRegisTournaments.data ==
                    null ||
                usertournamentProvider
                    .apiResponseRegisTournaments.data!.isEmpty) {
              return const Center(
                child: EmptyComponts(
                  image: "assets/images/no-data.svg",
                  showMessage: "No Tournaments",
                  height: 150,
                  width: 150,
                  addText: "...",
                ),
              );
            }
            var user = usertournamentProvider.apiResponseRegisTournaments.data;
            return registredtournamentCardBuilder(user);
          case Status.ERROR:
            return Center(
              child: ErrorComponent(
                errorMessage: usertournamentProvider
                    .apiResponseRegisTournaments.message
                    .toString(),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget hostedTournaments(BuildContext context, Size size) {
    return Consumer<UserHostRegTournamentViewModel>(
      builder: (context, usertournamentProvider, child) {
        switch (usertournamentProvider.apiResponseHostedTournaments.status) {
          case Status.LOADING:
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: AppMargin.large,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ShimerWidget.rectangular(
                  borderRadius: AppRadius.borderRadiusM,
                  verticalMargin: AppMargin.small,
                  hight: size.height * 0.2,
                );
              },
            );
          case Status.COMPLETED:
            if (usertournamentProvider.apiResponseHostedTournaments.data ==
                    null ||
                usertournamentProvider
                    .apiResponseHostedTournaments.data!.isEmpty) {
              return const Center(
                child: EmptyComponts(
                  image: "assets/images/no-data.svg",
                  showMessage: "No Tournaments",
                  height: 150,
                  width: 150,
                  addText: "...",
                ),
              );
            }
            var user = usertournamentProvider.apiResponseHostedTournaments.data;
            return hostedtournamentCardBuilder(user);
          case Status.ERROR:
            return Center(
              child: ErrorComponent(
                errorMessage: usertournamentProvider
                    .apiResponseHostedTournaments.message
                    .toString(),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  ListView registredtournamentCardBuilder(List<RegisteredTournaments>? user) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: user!.length > 4 ? 4 : user.length,
      itemBuilder: (context, index) {
        final values = user.reversed.toList()[index];
        return GestureDetector(
          onTap: () async {
            var provider = context.read<DetailsTouramentViewModel>();
            provider.getSingleTournament(values.id);
            await Navigator.pushNamed(context, RoutesName.tournamentDetails);
          },
          child: index == 3
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        context.read<BottomBarViewModel>().onTap(3, context);
                        context.read<MyClubViewModel>().setCurrenIndex(2);
                      },
                      child: const Text(
                        "View more",
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 18),
                      ),
                    ),
                  ),
                )
              : TournamentCard(
                  isDiscription: false,
                  status: values.registration?.status,
                  shortDescription: values.registration?.status,
                  tornamentDate: values.startDate ?? "",
                  tornamentName: values.title ?? "No title",
                  tornamentPlace: values.location ?? "No location",
                  touranmentCoverImage:
                      values.cover ?? AppProfilesCover.clubCover,
                ),
        );
      },
    );
  }

  ListView hostedtournamentCardBuilder(List<Datum>? user) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: user!.length > 4 ? 4 : user.length,
      itemBuilder: (context, index) {
        final values = user.reversed.toList()[index];
        return GestureDetector(
          onTap: () async {
            var provider = context.read<DetailsTouramentViewModel>();
            provider.getSingleTournament(values.id);
            await Navigator.pushNamed(context, RoutesName.tournamentDetails);
          },
          child: index == 3
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<BottomBarViewModel>(context, listen: false)
                            .onTap(3, context);

                        context.read<MyClubViewModel>().setCurrenIndex(1);
                      },
                      child: const Text(
                        "View more",
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 18),
                      ),
                    ),
                  ),
                )
              : TournamentCard(
                  shortDescription: values.shortDescription,
                  tornamentDate: values.startDate ?? "",
                  tornamentName: values.title ?? "No title",
                  tornamentPlace: values.location ?? "No location",
                  touranmentCoverImage:
                      values.cover ?? AppProfilesCover.clubCover,
                ),
        );
      },
    );
  }
}
