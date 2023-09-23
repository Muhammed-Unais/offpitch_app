import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/search_component.dart';
import 'package:offpitch_app/features/explore_view/components/tab2_upcoming_matches.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/res/components/tabbar_component.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    var exploreAndSearchProvider = context.read<ExploreViewViewModel>();

    tabController = TabController(length: 3, vsync: this);

    exploreAndSearchProvider.setExploretournaments = Exploretournaments.all;

    tabController.addListener(() {
      context.read<ExploreViewViewModel>().setSearchTabbarIndex(
            tabController.index,
          );
    });
    exploreAndSearchProvider.searchTextEditingController.addListener(() {
      if (mounted) {
        _listeningApiCalls();
      }
    });

    super.initState();
  }

  void _listeningApiCalls() {
    var exploreAndSearchProvider = context.read<ExploreViewViewModel>();
    final String text =
        exploreAndSearchProvider.searchTextEditingController.text;
    if (exploreAndSearchProvider.searchTextEditingController.text.isEmpty) {
      exploreAndSearchProvider.getExpAndSrchTournmts(
          query: 'filter=all&search=$text', sortingQuery: "all");

      exploreAndSearchProvider.getExpAndSrchTournmts(
          query: 'filter=all&search=$text', sortingQuery: "upcoming");
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          var exploreAndSearchProvider = context.read<ExploreViewViewModel>();
          exploreAndSearchProvider.searchTextEditingController.clear();
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            "TOURNAMENTS",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: SearchWidget(searchQuery: widget.searchQuery),
              )
            ];
          },
          body: Column(
            children: [
              TabbarWidget(
                onTap: (value) {},
                hight: 50,
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                tabController: tabController,
                tabOne: "All",
                tabTwo: "Live",
                tabThree: "Upcoming",
                selectedTabColor: AppColors.black,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    ExploreTournaments(),
                    ExploreTournaments(),
                    ExploreTournaments(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
