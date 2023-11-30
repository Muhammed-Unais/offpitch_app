import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/create_tournament/components/creat_tour_tab_one.dart';
import 'package:offpitch_app/src/create_tournament/components/creat_tour_tab_three.dart';
import 'package:offpitch_app/src/create_tournament/components/creat_tour_tab_two.dart';
import 'package:offpitch_app/src/create_tournament/view_model/create_tournament_view_model.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/res/components/tabbar_component.dart';
import 'package:offpitch_app/src/splash/view_model/user_view_model.dart';
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
  bool isVisible = true;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    controller.addListener(
      () {
        if (controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (isVisible != false) {
            setScrollFabVisibility(false);
          }
        } else {
          if (isVisible != true) {
            setScrollFabVisibility(true);
          }
        }
      },
    );
    super.initState();

    setCheckhasClubId();
  }

  void setScrollFabVisibility(bool value) {
    isVisible = value;
    setState(() {});
  }

  void setCheckhasClubId() {
    context.read<UserViewModel>().getUserClubId();
  }

  @override
  void dispose() {
    tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateTournamentViewModel(),
      child: Consumer2<CreateTournamentViewModel, UserViewModel>(
        builder: (context, createTournamentProvider, userViewModel, _) {
          return Scaffold(
            appBar: AppBar(
              shadowColor: AppColors.white,
              elevation: 2,
              title: const Text(
                "HOST TOURNAMENT",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            body: Column(
              children: [
                TabbarWidget(
                  onTap: (value) {
                    tabController.index = 0;
                  },
                  hight: 36,
                  margin: const EdgeInsets.only(
                      bottom: 20, top: 20, left: 20, right: 20),
                  selectedTabColor: AppColors.primary,
                  tabOne: "1",
                  tabTwo: "2",
                  tabThree: "3",
                  tabController: tabController,
                ),
                if (userViewModel.userClubId != null &&
                    userViewModel.userClubId!.isNotEmpty &&
                    userViewModel.userClubStatus != "awaiting")
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        CreateTournamentTabOne(
                          isVisible: isVisible,
                          controller: controller,
                          tabController: tabController,
                          formKey: formKey,
                          value: createTournamentProvider,
                        ),
                        CreatTournamentTabTwo(
                          value: createTournamentProvider,
                          formKey1: formKey1,
                          tabController: tabController,
                        ),
                        CreatTournamentTabThree(
                          tabController: tabController,
                          value: createTournamentProvider,
                        )
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          userViewModel.userClubStatus == "awaiting"
                              ? null
                              : Navigator.pushNamed(
                                  context,
                                  RoutesName.clubCreation,
                                );
                        },
                        child: EmptyComponts(
                          image: userViewModel.userClubStatus == "awaiting"
                              ? "assets/images/Waiting-pana.svg"
                              : "assets/images/no-club.svg",
                          showMessage:
                              userViewModel.userClubStatus == "awaiting"
                                  ? "Waiting for app approval"
                                  : "You didn't create a club",
                          height: 200,
                          width: 200,
                          addText: userViewModel.userClubStatus == "awaiting"
                              ? "...."
                              : "Create new",
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
