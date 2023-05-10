import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/view/home_view/components/home_carousels.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeTopCard extends StatelessWidget {
  const HomeTopCard({super.key});

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
          return Consumer<HomeAndExpViewModel>(
            builder: (context, value, _) {
              switch (value.allTournamentModel.status) {
                case Status.LOADING:
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  );
                case Status.COMPLETED:
                  final data = value
                      .allTournamentModel.data!.data.allTournaments.reversed
                      .toList()[index];
                  return HomeCarousels(
                    dateAndTime: data.startDate,
                    tournamentName: data.title,
                    isTouranment: isTournament[index],
                    image: data.cover,
                  );
                case Status.ERROR:
                  return  const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  );
                default:
                  return  const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
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
