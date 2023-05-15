import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/users_tournament_card.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:offpitch_app/view_model/user_profile_view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class UserWatchListBody extends StatelessWidget {
  const UserWatchListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<UserProfileViewModel>(
          builder: (context, value, _) {
            switch (value.userProfileWatchlist.status) {
              case Status.LOADING:
                return const Align(
                  child: CircularProgressIndicator(),
                );
              case Status.COMPLETED:
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.userProfileWatchlist.data?.data?.length,
                  itemBuilder: (context, index) {
                    final data = value.userProfileWatchlist.data?.data?.reversed
                        .toList()[index];
                    if (data == null) {
                     return  const EmptyComponts(
                          image: "assets/images/no-data.svg",
                          showMessage: "Add Tournament",
                          height: 200,
                          width: 200,
                          addText: "");
                    }
                    return InkWell(
                      onTap: () async {
                        final provider = Provider.of<DetailsTouramentViewModel>(
                            context,
                            listen: false);
                        provider.getSingleTournament(data.id);
                        await Navigator.pushNamed(context, "tournamentdetails");
                      },
                      child: UsersTournametCard(
                        isUserHost: false,
                        image: data.cover,
                        tournamentName: data.title,
                        tournamentPlace: "",
                        tournamentDate: data.startDate,
                      ),
                    );
                  },
                );
              case Status.ERROR:
                return ErrorComponent(
                  errorMessage: value.userProfileWatchlist.message ?? "",
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
