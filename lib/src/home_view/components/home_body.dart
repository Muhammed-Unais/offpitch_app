import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/search_component.dart';
import 'package:offpitch_app/src/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/src/home_view/components/home_all_tournament.dart';
import 'package:offpitch_app/src/home_view/components/home_chip_widget.dart';
import 'package:offpitch_app/src/home_view/components/home_top_card.dart';
import 'package:offpitch_app/src/home_view/view_model/home_view_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:provider/provider.dart';

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
    context.read<HomeViewModel>().homeTournamentsChip = HomeTournamentsEnum.all;
    fetchUserDetails();
    super.initState();
  }

  void fetchUserDetails() async {
    var exploreAndSearchProvider = context.read<ExploreViewViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (exploreAndSearchProvider.allTournaments.data == null ||
          exploreAndSearchProvider.liveTournaments.data == null) {
        exploreAndSearchProvider.getExpAndSrchTournmts(
            query: 'filter=all', sortingQuery: "all");
      }
      if (exploreAndSearchProvider.upcomingTournaments.data == null) {
        exploreAndSearchProvider.getExpAndSrchTournmts(
            query: 'filter=all', sortingQuery: "upcoming");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const SearchWidget(
            searchQuery: "",
            isHome: true,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Tournaments",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: size.height * 0.2,
            child: const HomeNewTornamentCards(),
          ),
          const SizedBox(height: 20),
          const HomeChipWidget(),
          Consumer<HomeViewModel>(
            builder: (context, homeProvider, _) {
              switch (homeProvider.homeTournamentsChip) {
                case HomeTournamentsEnum.all:
                  return HomeAllTournaments(
                    size: size,
                    homeTournaments: HomeTournamentsEnum.all,
                  );

                case HomeTournamentsEnum.live:
                  return HomeAllTournaments(
                    size: size,
                    homeTournaments: HomeTournamentsEnum.live,
                  );
                case HomeTournamentsEnum.upcoming:
                  return HomeAllTournaments(
                    size: size,
                    homeTournaments: HomeTournamentsEnum.upcoming,
                  );

                default:
                  return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
