import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
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
  late String? userClubId;
  late String? userClubStatus;

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

    setCheckhasClubId();
  }

  void setCheckhasClubId() {
    userClubId = context.read<UserViewModel>().userClubId;
    userClubStatus = context.read<UserViewModel>().userClubStatus;
  }

  @override
  void dispose() {
    tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateTournamentViewModel>(
      builder: (context, value, _) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              shadowColor: AppColors.white,
              elevation: 5,
              title: Text(
                "Host Tournament",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(
                  60,
                ),
                child: Column(
                  children: [
                    CreateTournamentViewTabbar(
                      tabController: tabController,
                      value: value,
                    ),
                    const SizedBox(
                      height: AppMargin.extraSmall,
                    )
                  ],
                ),
              ),
            ),
            body: userClubId != null &&
                    userClubId!.isNotEmpty &&
                    userClubStatus != "awaiting"
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
                : SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            userClubStatus=="awaiting"?null:
                            Navigator.pushNamed(
                                context, RoutesName.clubCreation);
                          },
                          child: EmptyComponts(
                            image: userClubStatus == "awaiting"
                                ? "assets/images/Waiting-pana.svg"
                                : "assets/images/no-club.svg",
                            showMessage: userClubStatus == "awaiting"
                                ? "Waiting for app approval"
                                : "You didn't create a club",
                            height: 200,
                            width: 200,
                            addText: userClubStatus == "awaiting"
                                ? "...."
                                : "Create new",
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
