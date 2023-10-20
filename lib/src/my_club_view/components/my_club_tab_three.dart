import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/users_tournament_card.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/src/my_club_view/view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:offpitch_app/src/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class MyClubTabThree extends StatefulWidget {
  const MyClubTabThree({super.key, this.userClubId});

  final String? userClubId;

  @override
  State<MyClubTabThree> createState() => _MyClubTabThreeState();
}

class _MyClubTabThreeState extends State<MyClubTabThree>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return widget.userClubId != null && widget.userClubId!.isNotEmpty
        ? Consumer<UserHostRegTournamentViewModel>(
            builder: (context, value, _) {
              switch (value.apiResponseRegisTournaments.status) {
                case Status.LOADING:
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  );
                case Status.COMPLETED:
                  if (value.apiResponseRegisTournaments.data == null ||
                      value.apiResponseRegisTournaments.data!.isEmpty) {
                    return EmptyComponts(
                      image: "assets/images/no-data.svg",
                      showMessage: "No Tournaments",
                      height: size.height * 0.15,
                      width: size.height * 0.15,
                      addText: "Registor...",
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    shrinkWrap: true,
                    itemCount: value.apiResponseRegisTournaments.data!.length,
                    itemBuilder: (context, index) {
                      final data = value
                          .apiResponseRegisTournaments.data!.reversed
                          .toList()[index];
                      return InkWell(
                        onTap: () async {
                          final provider =
                              context.read<DetailsTouramentViewModel>();
                          provider.getSingleTournament(data.id);
                          await Navigator.pushNamed(
                            context,
                            RoutesName.tournamentDetails,
                          );
                        },
                        child: UsersTournametCard(
                          image: data.cover,
                          tournamentName: data.title,
                          tournamentPlace: data.location,
                          tournamentDate: data.startDate.toString(),
                          isUserHost: false,
                          paymentStatus: data.teams!.status,
                        ),
                      );
                    },
                  );
                case Status.ERROR:
                  return ErrorComponent(
                    width: size.height * 0.15,
                    hight: size.height * 0.15,
                    errorMessage: value.apiResponseRegisTournaments.message!,
                  );
                default:
                  return const SizedBox();
              }
            },
          )
        : InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.clubCreation);
            },
            child: EmptyComponts(
              image: "assets/images/no-club.svg",
              showMessage: "You Don't have a club",
              height: size.height * 0.15,
              width: size.height * 0.15,
              addText: "Create new",
            ),
          );
  }
}
