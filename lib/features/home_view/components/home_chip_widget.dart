import 'package:flutter/material.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/features/home_view/view_model/home_view_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:provider/provider.dart';

class HomeChipWidget extends StatefulWidget {
  const HomeChipWidget({super.key});

  @override
  State<HomeChipWidget> createState() => _HomeChipWidgetState();
}

class _HomeChipWidgetState extends State<HomeChipWidget> {
  final List<String> chipNames = ["All", "Live", "Upcoming"];

  @override
  void initState() {
    context.read<HomeViewModel>().selcetedChip = chipNames[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.05,
      child: ListView.builder(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: chipNames.length,
        itemBuilder: (context, index) {
          final chipName = chipNames[index];
          return GestureDetector(
            onTap: () {
              context.read<HomeViewModel>().setSelectingChip(chipName);
              if (chipName == "Upcoming") {
                var exploreViewModel = context.read<ExploreViewViewModel>();
                exploreViewModel.getExpAndSrchTournmts(
                  query: "filter=all",
                  sortingQuery: "upcomingT",
                );
              }
            },
            child: Consumer<HomeViewModel>(
              builder: (context, homeProvider, _) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Chip(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    backgroundColor: homeProvider.selcetedChip == chipName
                        ? AppColors.black
                        : AppColors.lightgrey,
                    label: Text(chipName),
                    labelStyle: TextStyle(
                      color: homeProvider.selcetedChip == chipName
                          ? AppColors.white
                          : AppColors.grey,
                      fontFamily: "SFUIDisplay",
                      fontSize: 12,
                    ),
                    side: const BorderSide(
                      color: AppColors.lightgrey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
