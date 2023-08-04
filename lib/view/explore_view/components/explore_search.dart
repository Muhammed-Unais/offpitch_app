import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/explore_view_view_model.dart';
import 'package:provider/provider.dart';

enum PoupMenuButtons { all, upcoming }

class ExploreSearch extends StatelessWidget {
  const ExploreSearch({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final exploreViewModel =
        Provider.of<ExploreViewViewModel>(context, listen: false);
    PoupMenuButtons? sampleItem;
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: AppMargin.large,
            ),
            padding: const EdgeInsets.all(AppPadding.extraSmall),
            width: size.width * 0.75,
            height: size.height * 0.05,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(
                    0.5,
                  ),
                  blurRadius: 7,
                  offset: const Offset(
                    0,
                    3,
                  ),
                ),
              ],
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                AppRadius.borderRadiusS,
              ),
            ),
            child:
                Consumer<ExploreViewViewModel>(builder: (context, values, _) {
              return TextField(
                // controller: textEditingController,
                onChanged: (value) {
                  if (values.searchTabbarCount == 0) {
                    exploreViewModel.getExpAndSrchTournmts(
                        query: "filter=all&search=$value", sortingQuery: "all");
                  }

                  if (sampleItem == PoupMenuButtons.all) {
                    exploreViewModel.getExpAndSrchTournmts(
                        query: "filter=all&search=$value", sortingQuery: "all");
                  }
                  if (sampleItem == PoupMenuButtons.upcoming) {
                    exploreViewModel.getExpAndSrchTournmts(
                        query: "filter=all&search=$value",
                        sortingQuery: "upComing");
                  }
                  if (sampleItem == null) {
                    exploreViewModel.getExpAndSrchTournmts(
                        query: "filter=all&search=$value", sortingQuery: "all");
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  filled: false,
                  prefixIcon: Icon(
                    IconlyBroken.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              );
            }),
          ),
          Consumer<ExploreViewViewModel>(
            builder: (context, value, _) {
              return value.searchTabbarCount == 0
                  ? const Text(
                      "Live",
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  : PopupMenuButton(
                      initialValue: sampleItem,
                      icon: const Icon(IconlyBold.filter),
                      onSelected: (value) {
                        sampleItem = value;
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: PoupMenuButtons.all,
                          child: Row(
                            children: const [
                              Text("All"),
                            ],
                          ),
                          onTap: () {
                            exploreViewModel.getExpAndSrchTournmts(
                                query: 'filter=all', sortingQuery: "all");
                          },
                        ),
                        PopupMenuItem(
                          value: PoupMenuButtons.upcoming,
                          child: Row(
                            children: const [
                              Text("Upcoming"),
                            ],
                          ),
                          onTap: () async {
                            exploreViewModel.getExpAndSrchTournmts(
                                query: 'filter=all', sortingQuery: "upComing");
                          },
                        ),
                      ],
                    );
            },
          )
        ],
      ),
    );
  }
}
