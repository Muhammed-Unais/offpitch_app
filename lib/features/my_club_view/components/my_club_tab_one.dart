import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/features/my_club_view/components/club_detils_widget.dart';
import 'package:offpitch_app/features/my_club_view/components/club_player_widget.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
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
                      child:  EmptyComponts(
                        image: "assets/images/Waiting-pana.svg",
                        showMessage: "Waiting for app approval",
                        height: size.height * 0.15,
                        width: size.height * 0.15,
                        addText: "Refresh",
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClubDetailsWidget(size: size, data: data),
                        const ClubPlayerWidget(),
                      ],
                    ),
                  );
                case Status.ERROR:
                  return ErrorComponent(
                    hight: size.height * 0.15,
                    width: size.height * 0.15,
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
                  height: size.height * 0.15,
                  width: size.height * 0.15,
                  addText: createClubProvider.isClubCreate
                      ? "Refresh"
                      : "Create new",
                ),
              );
            },
          );
  }
}