import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/features/my_club_view/components/my_club_players.dart';
import 'package:offpitch_app/features/my_club_view/components/tabview_one_club_description.dart';
import 'package:offpitch_app/features/my_club_view/components/tabview_one_club_profile.dart';
import 'package:offpitch_app/features/my_club_view/components/tav_view_one_email_phone.dart';
import 'package:offpitch_app/features/club_creation_view/view_model/create_new_club_view_model.dart';
import 'package:offpitch_app/features/my_club_view/view_model/my_club_over_view_model.dart';
import 'package:provider/provider.dart';

class MyClubTabOne extends StatelessWidget {
  const MyClubTabOne({
    super.key,
    this.userClubId,
  });

  final String? userClubId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return userClubId != null && userClubId!.isNotEmpty
        ? Consumer<MyClubViewModel>(
            builder: (context, myClubViewModelProvider, _) {
              switch (myClubViewModelProvider.getClubApiResponse.status) {
                case Status.LOADING:
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  );
                case Status.COMPLETED:
                  final data = myClubViewModelProvider.getClubApiResponse.data;
                  if (data?.data?.status == "awaiting") {
                    return InkWell(
                      onTap: () {
                        myClubViewModelProvider.getMyClub(context);
                      },
                      child: const EmptyComponts(
                        image: "assets/images/Waiting-pana.svg",
                        showMessage: "Waiting for app approval",
                        height: 200,
                        width: 200,
                        addText: "Refresh",
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabViewOneClubProfile(
                        clubName: data?.data?.name ?? "No title",
                        image:
                            data?.data?.profile ?? AppProfilesCover.clubCover,
                        playerCount: data?.data?.players.length ?? 0,
                      ),
                      Expanded(
                        child: TabViewOneClubDescription(
                          description:
                              data?.data?.description ?? "No description",
                        ),
                      ),
                      const SizedBox(
                        height: AppPadding.small,
                      ),
                      TabbarViewOneEmailPhone(
                        hight: size.height * 0.08,
                        email: data?.data?.email ?? "No email",
                        phone: data?.data?.phone ?? 0,
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: AppColors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppMargin.large,
                          vertical: AppMargin.medium,
                        ),
                        child: Text(
                          "Club players",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const Expanded(
                        child: MyClubPlayers(),
                      ),
                      const SizedBox(
                        height: AppPadding.small,
                      ),
                    ],
                  );
                case Status.ERROR:
                  return ErrorComponent(
                    hight: size.height*0.15,
                    width: size.height*0.15,
                    errorMessage:
                        myClubViewModelProvider.getClubApiResponse.message ??
                            "",
                  );
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          )
        : Consumer2<CreateNewClubViewModel, MyClubViewModel>(
            builder: (context, createClubProvider, myClubviewModelProvider, _) {
              return InkWell(
                onTap: () {
                  createClubProvider.isClubCreate
                      ? myClubviewModelProvider.getMyClub(context)
                      : Navigator.pushNamed(context, RoutesName.clubCreation);
                },
                child: EmptyComponts(
                  image: createClubProvider.isClubCreate
                      ? "assets/images/Waiting-pana.svg"
                      : "assets/images/no-club.svg",
                  showMessage: createClubProvider.isClubCreate
                      ? "Waiting for app approval"
                      : "You didn't create a club",
                  height: 200,
                  width: 200,
                  addText: createClubProvider.isClubCreate
                      ? "Refresh"
                      : "Create new",
                ),
              );
            },
          );
  }
}
