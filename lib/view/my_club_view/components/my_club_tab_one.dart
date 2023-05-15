import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_players.dart';
import 'package:offpitch_app/view/my_club_view/components/tabview_one_club_description.dart';
import 'package:offpitch_app/view/my_club_view/components/tabview_one_club_profile.dart';
import 'package:offpitch_app/view/my_club_view/components/tav_view_one_email_phone.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:provider/provider.dart';

class MyClubTabOne extends StatelessWidget {
  const MyClubTabOne({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<MyClubViewModel>(
      builder: (context, value, _) {
        switch (value.apiResponse.status) {
          case Status.LOADING:
            return const Center(
              child:  CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            );
          case Status.COMPLETED:
            final data = value.apiResponse.data;
            if (value.apiResponse.data!.message
                .contains("You don't have a club")) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.clubCreation);
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
              return SingleChildScrollView(
                child: SizedBox(
                  // height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabViewOneClubProfile(
                        clubName: data?.data?.name ??"No title",
                        image: data?.data?.profile??AppProfilesCover.clubCover,
                        playerCount: data?.data?.players.length ??0,
                      ),
                      TabViewOneClubDescription(
                        hight: size.height * 0.2,
                        description: data?.data?.description ??"No description",
                      ),
                      const SizedBox(
                        height: AppPadding.small,
                      ),
                      TabbarViewOneEmailPhone(
                        hight: size.height * 0.08,
                        email: data?.data?.email?? "No email",
                        phone: data?.data?.phone ?? 0,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppPadding.large),
                        child: Divider(
                          thickness: 0.5,
                          color: AppColors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppMargin.large,
                            vertical: AppMargin.medium),
                        child: Text(
                          "Players",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      // Add players and show player details======
                      MyClubPlayers(hight: size.height * 0.23),
                      const SizedBox(
                        height: AppPadding.medium,
                      ),
                    ],
                  ),
                ),
              );
            }
          case Status.ERROR:
            return ErrorComponent(
              errorMessage: value.apiResponse.message ??"",
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
