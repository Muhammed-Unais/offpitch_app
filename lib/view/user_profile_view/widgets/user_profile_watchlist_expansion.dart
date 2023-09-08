import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:offpitch_app/view_model/user_profile_view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class UserProfileWatchListExpansion extends StatelessWidget {
  const UserProfileWatchListExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(
        bottom: BorderSide(color: AppColors.grey, width: 0.4),
      ),
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      leading: const Icon(Icons.watch_later_outlined),
      title: Text(
        "Watchlist",
        style: Theme.of(context).textTheme.labelLarge,
      ),
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      children: <Widget>[
        Consumer<UserProfileViewModel>(
          builder: (context, value, _) {
            final data = value.userProfileWatchlist.data?.data;
            if (data == null||data.isEmpty) {
              return const Center(
                child: EmptyComponts(
                  image: "assets/images/no-data.svg",
                  showMessage: "No watchlist",
                  height: 100,
                  width: 100,
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
                          child: Text(
                            "View all",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      )
                    : Card(
                        shadowColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                              width: 0.1, color: AppColors.black),
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
        const SizedBox(height: 10),
      ],
    );
  }
}
