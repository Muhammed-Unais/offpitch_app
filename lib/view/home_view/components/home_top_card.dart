
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/home_view/components/home_carousels.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeTopCard extends StatefulWidget {
  const HomeTopCard({super.key});

  @override
  State<HomeTopCard> createState() => _HomeTopCardState();
}

class _HomeTopCardState extends State<HomeTopCard> {
  @override
  void didChangeDependencies() {
    final values = Provider.of<HomeAndExpViewModel>(context, listen: false);
    values.userFuture ??= values.getAllTournaments();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> isTournament = [false, true, true, true];
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 4,
      width: size.width,
      margin: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: AppMargin.large,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(
              0.5,
            ),
            blurRadius: 7,
            offset: const Offset(
              0,
              3,
            ),
          ),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusM,
        ),
      ),
      child: Swiper(
        duration: 1000,
        autoplay: false,
        curve: Curves.ease,
        itemCount: 4,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: Provider.of<HomeAndExpViewModel>(context, listen: false)
                .userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                final data = snapshot.data?.data?.allTournaments?.reversed
                    .toList()[index];
                return HomeCarousels(
                  dateAndTime: data?.startDate ?? "",
                  tournamentName: data?.title ?? "",
                  isTouranment: isTournament[index],
                  image: data?.cover ?? AppProfilesCover.clubCover,
                );
              }
            },
          );
        },
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            size: 4,
            color: AppColors.grey,
            activeColor: AppColors.primary,
          ),
        ),
      ),
    );
  }
}