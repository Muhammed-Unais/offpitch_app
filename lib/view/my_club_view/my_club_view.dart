import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_appbar_tabar.dart';
import 'package:offpitch_app/view/my_club_view/components/tabview_one_club_description.dart';
import 'package:offpitch_app/view/my_club_view/components/tabview_one_club_profile.dart';
import 'package:offpitch_app/view_model/my_club_view_model.dart';
import 'package:provider/provider.dart';

class MyClubView extends StatelessWidget {
  const MyClubView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(120.00),
          child: MyclubAppbarTabbar(),
        ),
        body: TabBarView(
          children: [
            Consumer<MyClubViewModel>(
              builder: (context, value, _) {
                switch (value.apiResponse.status) {
                  case Status.LOADING:
                    return const Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  case Status.COMPLETED:
                    final data = value.apiResponse.data!;
                    if (value.apiResponse.data!.message
                        .contains("You don't have a club")) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "clubcreation");
                        },
                        child: EmptyComponts(
                          image: "assets/images/no-club.svg",
                          showMessage: "${value.apiResponse.data!.message}!",
                          height: 200,
                          width: 200,
                          addText: "Create new",
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          TabViewOneClubProfile(
                            clubName: data.data!.name,
                            image: data.data!.profile,
                            playerCount: data.data!.players.length,
                          ),
                          TabViewOneClubDescription(
                            description: data.data!.description,
                            email: data.data!.email,
                            phone: data.data!.phone,
                            hight: size.height * 0.22,
                            width: size.width,
                          ),
                        ],
                      );
                    }
                  case Status.ERROR:
                    return ErrorComponent(
                      errorMessage: value.apiResponse.message!,
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const Text(""),
            const Text(""),
          ],
        ),
      ),
    );
  }
}
