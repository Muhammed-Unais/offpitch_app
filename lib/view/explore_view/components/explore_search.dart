import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/explore_view_view_model.dart';
import 'package:provider/provider.dart';

enum PoupMenuButtons { all, upcoming }

class ExploreSearch extends StatelessWidget {
  const ExploreSearch({super.key});

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
            child: TextField(
              // controller: textEditingController,
              onChanged: (value) {
                log(value);
                  exploreViewModel.getExpAndSrchTournmts(
                      query: "filter=all&search=$value");
                if(sampleItem == PoupMenuButtons.upcoming){
                     exploreViewModel.getExpAndSrchTournmts(
                      query: "filter=upcoming&search=$value");
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
            ),
          ),
          PopupMenuButton(
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
                  exploreViewModel.getExpAndSrchTournmts(query: 'filter=all');
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
                      query: 'filter=upcoming');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
