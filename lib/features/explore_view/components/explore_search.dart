import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:provider/provider.dart';

enum PoupMenuButtons { all, upcoming }

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PoupMenuButtons? sampleItem;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
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
              onChanged: (value) {
                var exploreViewModel = context.read<ExploreViewViewModel>();
                if (values.searchTabbarCount == 0) {
                  exploreViewModel.getExpAndSrchTournmts(
                      query: "filter=all&search=$value",
                      sortingQuery: "all",
                      isNotify: true);
                }

                if (sampleItem == PoupMenuButtons.all) {
                  exploreViewModel.getExpAndSrchTournmts(
                      query: "filter=all&search=$value",
                      sortingQuery: "all",
                      isNotify: true);
                }
                if (sampleItem == PoupMenuButtons.upcoming) {
                  exploreViewModel.getExpAndSrchTournmts(
                      query: "filter=all&search=$value",
                      sortingQuery: "upComing",
                      isNotify: true);
                }
                if (sampleItem == null) {
                  exploreViewModel.getExpAndSrchTournmts(
                      query: "filter=all&search=$value",
                      isNotify: true,
                      sortingQuery: "all");
                }
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "",
                hintStyle: TextStyle(
                  decorationStyle: TextDecorationStyle.solid,
                  decoration: TextDecoration.none,
                  fontSize: 12,
                  fontFamily: "SFUIDisplay",
                  color: AppColors.black,
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
  //  Consumer<ExploreViewViewModel>(
  //           builder: (context, value, _) {
  //             return value.searchTabbarCount == 0
  //                 ? const Text(
  //                     "Live",
  //                     style: TextStyle(
  //                         color: AppColors.primary,
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold),
  //                   )
  //                 : PopupMenuButton(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                     surfaceTintColor: Colors.white,
  //                     initialValue: sampleItem,
  //                     icon: const Icon(IconlyBold.filter),
  //                     onSelected: (value) {
  //                       sampleItem = value;
  //                     },
  //                     itemBuilder: (context) => [
  //                       PopupMenuItem(
  //                         value: PoupMenuButtons.all,
  //                         child: Row(
  //                           children: const [
  //                             Text("All"),
  //                           ],
  //                         ),
  //                         onTap: () {
  //                           exploreViewModel.getExpAndSrchTournmts(
  //                               query: 'filter=all',
  //                               sortingQuery: "all",
  //                               isNotify: true);
  //                         },
  //                       ),
  //                       PopupMenuItem(
  //                         value: PoupMenuButtons.upcoming,
  //                         child: Row(
  //                           children: const [
  //                             Text("Upcoming"),
  //                           ],
  //                         ),
  //                         onTap: () async {
  //                           exploreViewModel.getExpAndSrchTournmts(
  //                               query: 'filter=all',
  //                               sortingQuery: "upComing",
  //                               isNotify: true);
  //                         },
  //                       ),
  //                     ],
  //                   );
  //           },
  //         )