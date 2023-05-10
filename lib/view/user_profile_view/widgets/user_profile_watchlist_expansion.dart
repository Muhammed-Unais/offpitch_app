import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:offpitch_app/view_model/user_profile_view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class UserProfileWatchListExpansion extends StatelessWidget {
  const UserProfileWatchListExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        "Watchlist",
        style: Theme.of(context).textTheme.labelLarge,
      ),
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.userWatchlist);
            },
            child: Text(
              "View all",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
        const Divider(
          color: AppColors.black,
          thickness: 0.5,
        ),
        Consumer<UserProfileViewModel>(
          builder: (context, value, _) {
            final data = value.userProfileWatchlist.data?.data;
            if (data == null) {
              return const Center(
                child: EmptyComponts(
                  image: "assets/images/no-data.svg",
                  showMessage: "Add Tournaments",
                  height: 100,
                  width: 100,
                  addText: "",
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length > 3 ? 3 : data.length,
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(width: 0.1, color: AppColors.black),
                  ),
                  elevation: 2,
                  surfaceTintColor: AppColors.white,
                  child: ListTile(
                    onTap: () {
                      Provider.of<DetailsTouramentViewModel>(context,
                              listen: false)
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
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    subtitle: Text(
                      data[index].startDate ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                );
              },
            );
          },
        ),
        const Divider(
          color: AppColors.black,
          thickness: 0.5,
        ),
      ],
    );
  }
}
