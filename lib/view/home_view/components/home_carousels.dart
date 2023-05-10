import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/view_model/bottom_bar_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeCarousels extends StatelessWidget {
  const HomeCarousels(
      {super.key,
      required this.image,
      required this.isTouranment,
      required this.tournamentName,
      required this.dateAndTime});

  final String image;
  final bool isTouranment;
  final String tournamentName;
  final String dateAndTime;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppRadius.borderRadiusM,
            ),
            image: !isTouranment
                ? const DecorationImage(
                    image: AssetImage("assets/images/hero-img.jpg"),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(221, 18, 15, 15),
                      BlendMode.darken,
                    ),
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      image,
                    ),
                  ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: !isTouranment ? 55 : 110,
          child: Text(
            !isTouranment
                ? "Elevate Your\nFootball Experience"
                : tournamentName,
            style: !isTouranment
                ? Theme.of(context).textTheme.labelLarge
                : const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ),
        isTouranment
            ? Positioned(
                left: 20,
                bottom: 94,
                child: Text(
                  dateAndTime,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            : const SizedBox(),
        !isTouranment
            ? Positioned(
                left: 20,
                bottom: 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    Provider.of<BottomBarViewModel>(context,listen: false).onTap(3, context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.large),
                    child: Text(
                      "Get Started",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
