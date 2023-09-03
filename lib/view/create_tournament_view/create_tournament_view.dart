import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
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

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    controller.addListener(
      () {
        final provider =
            Provider.of<CreateTournamentViewModel>(context, listen: false);
        if (controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (provider.isVisible != false) {
            provider.setScrollFabVisibility(false);
          }
        } else {
          if (provider.isVisible != true) {
            provider.setScrollFabVisibility(true);
          }
        }
      },
    );
    super.initState();

    setCheckhasClubId();
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
    return Consumer2<CreateTournamentViewModel, UserViewModel>(
      builder: (context, value, userViewModel, _) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              shadowColor: AppColors.white,
              elevation: 2,
              title: Text(
                "Host your tournament",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Column(
              children: [
                CreateTournamentViewTabbar(
                  tabController: tabController,
                  value: value,
                ),
                if (userViewModel.userClubId != null &&
                    userViewModel.userClubId!.isNotEmpty &&
                    userViewModel.userClubStatus != "awaiting")
                  Expanded(
                    child: TabBarView(
                      physics:const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        CreateTournamentTabOne(
                          controller: controller,
                          tabController: tabController,
                          formKey: formKey,
                          value: value,
                        ),
                        CreatTournamentTabTwo(
                          value: value,
                          formKey1: formKey1,
                          tabController: tabController,
                        ),
                        CreatTournamentTabThree(
                          value: value,
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
                                  context, RoutesName.clubCreation);
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
          ),
        );
      },
    );
  }
}
