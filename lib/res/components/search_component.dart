import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/explore/view_model/explore_search_view_model.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.textEditingController});

  final TextEditingController textEditingController;
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
      child: Center(
        child: TextField(
          controller: textEditingController,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "SFUIDisplay",
            fontSize: 12,
          ),
          onChanged: (value) {
            var exploreViewModel = context.read<ExploreSearchViewModel>();
            exploreViewModel.getSearchResultsTournaments(
              query: "search=$value",
            );
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
      ),
    );
  }
}
