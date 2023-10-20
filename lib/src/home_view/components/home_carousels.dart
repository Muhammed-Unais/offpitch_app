import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/src/home_view/components/home_frosted_glass_widget.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class HomeCarousels extends StatelessWidget {
  const HomeCarousels({
    super.key,
    required this.image,
    required this.tournamentName,
    required this.dateAndTime,
    required this.location,
  });

  final String image;
  final String tournamentName;
  final String dateAndTime;
  final String location;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CachedNetworkImage(
      imageUrl: image,
      placeholder: (context, url) => ImageAndFrostedGlass(
        size: size,
        dateAndTime: dateAndTime,
        tournamentName: tournamentName,
        location: location,
        imageProvider: const AssetImage(
          "assets/images/hero-img.jpg",
        ),
      ),
      errorWidget: (context, url, error) {
        return ImageAndFrostedGlass(
          size: size, 
          dateAndTime: dateAndTime,
          tournamentName: tournamentName,
          location: location,
          imageProvider: const AssetImage(
            "assets/images/hero-img.jpg",
          ),
        );
      },
      imageBuilder: (context, imageProvider) {
        return ImageAndFrostedGlass(
          imageProvider: imageProvider,
          size: size,
          dateAndTime: dateAndTime,
          tournamentName: tournamentName,
          location: location,
        );
      },
    );
  }
}

class ImageAndFrostedGlass extends StatelessWidget {
  const ImageAndFrostedGlass({
    super.key,
    required this.size,
    required this.dateAndTime,
    required this.tournamentName,
    required this.location,
    required this.imageProvider,
  });

  final Size size;
  final String dateAndTime;
  final String tournamentName;
  final String location;
  final ImageProvider<Object> imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: size.width - 80,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(right: 16, bottom: 1),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusS,
        ),
        image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
      ),
      child: FrostedGlassBox(
        stackLastWidget: FrostedGlassChildWidget(
          hight: size.height * 0.1,
          width: size.width,
          startinDate: dateAndTime,
          tournamentName: tournamentName,
        ),
        location: location,
        hight: size.height * 0.1,
        width: size.width,
      ),
    );
  }
}
