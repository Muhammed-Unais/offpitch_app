import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view/home_view/components/home_carousels.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/home_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class HomeTopCard extends StatefulWidget {
  const HomeTopCard({super.key});

  @override
  State<HomeTopCard> createState() => _HomeTopCardState();
}

class _HomeTopCardState extends State<HomeTopCard> {
  @override
  void initState() {
    var homeProvider = context.read<HomeViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider.apiResponse?.data ?? homeProvider.getAllTournaments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: size.width,
      margin: const EdgeInsets.symmetric(
        vertical: AppMargin.small,
        horizontal: AppMargin.large,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusM,
        ),
      ),
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) {
          return swiperWidget(homeViewModel);
        },
      ),
    );
  }

  Swiper swiperWidget(HomeViewModel homeViewModel) {
    return Swiper(
      physics: homeViewModel.count == 0
          ? const NeverScrollableScrollPhysics()
          : const ScrollPhysics(),
      duration: 1000,
      autoplayDelay: 5000,
      autoplay: true,
      curve: Curves.linearToEaseOut,
      itemCount: homeViewModel.count + 1,
      itemBuilder: (context, index) {
        AllTournament? data;
        if (index != 0) {
          data = homeViewModel.apiResponse?.data?.data?.allTournaments?.reversed
              .toList()[index - 1];
        }
        switch (homeViewModel.apiResponse!.status) {
          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ),
            );

          case Status.COMPLETED:
            return index == 0
                ? const HomeTournametnCard()
                : GestureDetector(
                    onTap: () async {
                      var provider = context.read<DetailsTouramentViewModel>();
                      provider.getSingleTournament(data?.id);
                      await Navigator.pushNamed(
                          context, RoutesName.tournamentDetails);
                    },
                    child: HomeCarousels(
                      dateAndTime: data?.startDate ?? "",
                      tournamentName: data?.title ?? "",
                      image: data?.cover ?? AppProfilesCover.clubCover,
                    ),
                  );
          case Status.ERROR:
            return Center(
              child: Text(
                homeViewModel.apiResponse!.message.toString(),
              ),
            );

          default:
            return const SizedBox();
        }
      },
      pagination: const SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          size: 5,
          color: AppColors.grey,
          activeColor: AppColors.primary,
        ),
      ),
    );
  }
}
