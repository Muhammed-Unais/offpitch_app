import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/bottom_bar_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeCarousels extends StatelessWidget {
  const HomeCarousels(
      {super.key,
      required this.image,
      required this.tournamentName,
      required this.dateAndTime});

  final String image;
  final String tournamentName;
  final String dateAndTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusM,
        ),
        image: DecorationImage(
          colorFilter: const ColorFilter.mode(
            Color.fromARGB(60, 18, 15, 15),
            BlendMode.darken,
          ),
          fit: BoxFit.cover,
          image: NetworkImage(
            image,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            bottom: 110,
            child: Text(
              tournamentName,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
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
        ],
      ),
    );
  }
}

class HomeTournametnCard extends StatelessWidget {
  const HomeTournametnCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusM,
        ),
        image: const DecorationImage(
          image: AssetImage("assets/images/hero-img.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
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
                padding: EdgeInsets.symmetric(horizontal: AppPadding.large),
                child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
