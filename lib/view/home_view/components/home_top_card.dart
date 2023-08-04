import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/home_view/components/home_carousels.dart';
import 'package:offpitch_app/view_model/bottom_bar_viewmodel.dart';
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
    values.setValue();
    values.userFuture ??= values.getAllTournaments();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel =
        Provider.of<HomeAndExpViewModel>(context, listen: false);
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
      child: swiperWidget(homeViewModel, isTournament),
    );
  }

  Swiper swiperWidget(
      HomeAndExpViewModel homeViewModel, List<bool> isTournament) {
    return Swiper(
      physics: homeViewModel.count == null || homeViewModel.count == 0
          ? const NeverScrollableScrollPhysics()
          : const ScrollPhysics(),
      duration: 2000,
      autoplay: false,
      curve: Curves.easeInOut,
      itemCount: homeViewModel.count == null || homeViewModel.count == 0
          ? 1
          : homeViewModel.count!,
      itemBuilder: (context, index) {
        return homeViewModel.count == null || homeViewModel.count == 0
            ? const HomeDefaultCard()
            : futureBuilderOfSwiper(
                context,
                homeViewModel,
                index,
                isTournament,
              );
      },
      pagination: const SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          size: 4,
          color: AppColors.grey,
          activeColor: AppColors.primary,
        ),
      ),
    );
  }

// future builder=============
  FutureBuilder<AllTournamentsModel> futureBuilderOfSwiper(BuildContext context,
      HomeAndExpViewModel homeViewModel, int index, List<bool> isTournament) {
    return FutureBuilder(
      future:
          Provider.of<HomeAndExpViewModel>(context, listen: false).userFuture,
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
          AllTournament? data;
          if (homeViewModel.count != null && homeViewModel.count != 0) {
            data =
                snapshot.data?.data?.allTournaments?.reversed.toList()[index];
          }

          return HomeCarousels(
            dateAndTime: data?.startDate ?? "",
            tournamentName: data?.title ?? "",
            isTouranment: isTournament[index],
            image: data?.cover ?? AppProfilesCover.clubCover,
          );
        }
      },
    );
  }
}

class HomeDefaultCard extends StatelessWidget {
  const HomeDefaultCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppRadius.borderRadiusM,
              ),
              image: const DecorationImage(
                image: AssetImage("assets/images/hero-img.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 55,
            child: Text(
              "Elevate Your\nFootball Experience",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Positioned(
            left: 20,
            bottom: 10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                Provider.of<BottomBarViewModel>(context, listen: false)
                    .onTap(3, context);
              },
              child: const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppPadding.large),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      );
  }
}
