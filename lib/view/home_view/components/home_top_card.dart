import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/view/home_view/components/home_carousels.dart';
import 'package:offpitch_app/res/constats.dart';

class HomeTopCard extends StatelessWidget {
  const HomeTopCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<bool> isTournament = [false, true, true, true];
    List<String> image = [
      "assets/images/hero-img.jpg",
      "assets/images/pexels-dids-1653090.jpg",
      "assets/images/pexels-francesco-paggiaro-705794.jpg",
      "assets/images/pexels-nothing-ahead-6800746.jpg"
    ];
    List<String> touranmentName = [
      "Test Tourament",
      "Test Tourament",
      "Test Tourament",
      "Test Tourament"
    ];
    List<String> dateAndTime = [
      "12 Mar 2021,Pune",
      "12 Mar 2021,Pune",
      "12 Mar 2021,Pune",
      "12 Mar 2021,Pune"
    ];
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
        curve: Curves.bounceOut,
        itemCount: 4,
        itemBuilder: (context, index) {
          return HomeCarousels(
            dateAndTime: dateAndTime[index],
            tournamentName: touranmentName[index],
            isTouranment: isTournament[index],
            image: image[index],
          );
        },
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(size: 4,
            color: AppColors.grey,
            activeColor: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
