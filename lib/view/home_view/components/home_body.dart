
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view/home_view/components/home_top_card.dart';
import 'package:offpitch_app/view/home_view/components/home_topbar.dart';
import 'package:offpitch_app/view/home_view/components/home_upconing_tites.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/home_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     final values = Provider.of<HomeAndExpViewModel>(context, listen: false);
    values.userFuture ??= values.getAllTournaments();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          // homw top icon and iconbutton
          const HommeTopBar(),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: size.height,
                  margin: const EdgeInsets.only(
                    top: AppMargin.extraLarge * 5,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        AppRadius.borderRadiusL,
                      ),
                      topRight: Radius.circular(
                        AppRadius.borderRadiusL,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: size.height / 11),
                      // home upcoming title
                      const HomeUpcomingtitle(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: AppMargin.small,
                              ),
                              FutureBuilder(
                                future: Provider.of<HomeAndExpViewModel>(context).userFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppMargin.large,
                                      ),
                                      itemCount: 3,
                                      itemBuilder: (context, index) {
                                        return ShimerWidget.rectangular(
                                          borderRadius: AppRadius.borderRadiusM,
                                          verticalMargin: AppMargin.small,
                                          hight: size.height * 0.2,
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: ErrorComponent(
                                        errorMessage: snapshot.error.toString(),
                                      ),
                                    );
                                  } else {
                                    final user =
                                        snapshot.data?.data?.allTournaments!;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          user!.length > 3 ? 3 : user.length,
                                      itemBuilder: (context, index) {
                                        final values =
                                            user.reversed.toList()[index];
                                        return InkWell(
                                          onTap: () async {
                                            final provider = Provider.of<
                                                    DetailsTouramentViewModel>(
                                                context,
                                                listen: false);
                                            provider
                                                .getSingleTournament(values.id);
                                            await Navigator.pushNamed(
                                                context, RoutesName.tournamentDetails);
                                          },
                                          child: TournamentCard(
                                            shortDescription:
                                                values.shortDescription ??
                                                    "No Description",
                                            tornamentDate:
                                                values.startDate ?? "",
                                            tornamentName:
                                                values.title ?? "No title",
                                            tornamentPlace: values.location ??
                                                "No location",
                                            touranmentCoverImage:
                                                values.cover ??
                                                    AppProfilesCover.clubCover,
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Home carosole card==============
                const HomeTopCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}