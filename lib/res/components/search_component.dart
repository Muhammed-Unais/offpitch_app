import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/explore_view/view_model/explore_view_view_model.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    this.isHome = false,
    required this.searchQuery,
  });

  final bool isHome;
  final String searchQuery;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  void navigateToExploreScreen(String query) {
    Navigator.pushNamed(context, "explore", arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.lightgrey,
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusS,
        ),
      ),
      child: Consumer<ExploreViewViewModel>(
        builder: (context, values, _) {
          return Center(
            child: TextField(
              controller:
                  widget.isHome ? null : values.searchTextEditingController,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "SFUIDisplay",
                fontSize: 12,
              ),
              onSubmitted: widget.isHome
                  ? (value) {
                      navigateToExploreScreen(value);
                    }
                  : null,
              onChanged: widget.isHome
                  ? null
                  : (value) {
                      var exploreViewModel =
                          context.read<ExploreViewViewModel>();
                      switch (exploreViewModel.exploretournaments) {
                        case Exploretournaments.all:
                          exploreViewModel.getExpAndSrchTournmts(
                            query: "filter=all&search=$value",
                            sortingQuery: "all",
                          );
                          break;
                        case Exploretournaments.live:
                          exploreViewModel.getExpAndSrchTournmts(
                            query: "filter=all&search=$value",
                            sortingQuery: "all",
                          );
                          break;
                        case Exploretournaments.upcoming:
                          exploreViewModel.getExpAndSrchTournmts(
                            query: "filter=all&search=$value",
                            sortingQuery: "upcoming",
                          );
                          break;
                        default:
                      }
                    },
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 13),
                border: InputBorder.none,
                hintText: "Search by tournaments,place and club",
                hintStyle: TextStyle(
                  decorationStyle: TextDecorationStyle.solid,
                  decoration: TextDecoration.none,
                  fontSize: 12,
                  fontFamily: "SFUIDisplay",
                  color: AppColors.grey,
                  fontWeight: FontWeight.normal,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
