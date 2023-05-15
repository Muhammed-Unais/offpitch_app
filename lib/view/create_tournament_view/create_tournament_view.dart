import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_tab_one.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_tab_three.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_tab_two.dart';
import 'package:offpitch_app/view/create_tournament_view/components/creat_tour_tabbar.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:offpitch_app/view_model/create_tournament_view_model/create_tournament_view_model.dart';
import 'package:provider/provider.dart';

class CreateTournamentView extends StatefulWidget {
  const CreateTournamentView({super.key});

  @override
  State<CreateTournamentView> createState() => _CreateTournamentViewState();
}

class _CreateTournamentViewState extends State<CreateTournamentView>
    with TickerProviderStateMixin {
  late TabController tabController;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    controller.addListener(() {
      final provider =
          Provider.of<CreateTournamentViewModel>(context, listen: false);
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (provider.isVisible != false) {
          provider.setScrollFabVisibility(false);
        }
      } else {
        if (provider.isVisible != true) {
          provider.setScrollFabVisibility(true);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userClubId =
        Provider.of<UserViewModel>(context, listen: false).userClubId;
    return Consumer<CreateTournamentViewModel>(
      builder: (context, value, _) {
        log(value.isVisible.toString());
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Host Tournament",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(
                  60,
                ),
                child: CreateTournamentViewTabbar(
                  tabController: tabController,
                  value: value,
                ),
              ),
            ),
            body: userClubId != null && userClubId.isNotEmpty
                ? TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Tab one=====
                      CreateTournamentTabOne(
                        controller: controller,
                        tabController: tabController,
                        formKey: formKey,
                        value: value,
                      ),
                      // Tab two====
                      CreatTournamentTabTwo(
                        value: value,
                        formKey1: formKey1,
                        tabController: tabController,
                      ),
                      // Tab three====
                      CreatTournamentTabThree(
                        value: value,
                      )
                    ],
                  )
                : InkWell(
                    onTap: () {
                      
                    },
                    child: const EmptyComponts(
                      image: "assets/images/no-club.svg",
                      showMessage: "You didn't create a club",
                      height: 200,
                      width: 200,
                      addText: "Create new",
                    ),
                  ),
          ),
        );
      },
    );
  }
}
