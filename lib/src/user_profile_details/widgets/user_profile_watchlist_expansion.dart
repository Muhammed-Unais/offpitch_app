import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/src/tournament_details/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/src/user_profile_details/view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class UserProfileWatchListExpansion extends StatelessWidget {
  const UserProfileWatchListExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ExpansionTile(
      shape: const Border(
        bottom: BorderSide(color: AppColors.grey, width: 0.4),
      ),
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      leading: const Icon(
        Icons.watch_later_outlined,
        color: AppColors.black,
      ),
      title: const Text(
        "Watchlist",
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      children: <Widget>[
        Consumer<UserProfileViewModel>(
          builder: (context, value, _) {
            final data = value.userProfileWatchlist.data?.data;
            if (data == null || data.isEmpty) {
              return Center(
                child: EmptyComponts(
                  image: "assets/images/no-data.svg",
                  showMessage: "No watchlist",
                  height: size.height * 0.15,
                  width: size.height * 0.15,
                  addText: "",
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length > 4 ? 4 : data.length,
              itemBuilder: (context, index) {
                return index == 4
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.userWatchlist);
                          },
                          child: const Text(
                            "View all",
                            style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      )
                    : Card(
                        shadowColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                            width: 0.1,
                            color: AppColors.black,
                          ),
                        ),
                        elevation: 2,
                        surfaceTintColor: AppColors.white,
                        child: ListTile(
                          onTap: () {
                            context
                                .read<DetailsTouramentViewModel>()
                                .getSingleTournament(data[index].id);
                            Navigator.pushNamed(
                                context, RoutesName.tournamentDetails);
                          },
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                              data[index].cover ?? AppProfilesCover.clubCover,
                            ),
                          ),
                          title: Text(
                            data[index].title ?? "",
                            style: const TextStyle(
                              fontFamily: "Lato",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          subtitle: Text(
                            data[index].startDate ?? "",
                            style: const TextStyle(
                              fontFamily: "Lato",
                              fontSize: 12,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      );
              },
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
