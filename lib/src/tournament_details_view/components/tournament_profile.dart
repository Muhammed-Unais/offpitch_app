import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:offpitch_app/res/components/users_tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class TournamentProfile extends StatelessWidget {
  const TournamentProfile(
      {super.key,
      required this.hight,
      required this.width,
      required this.image});

  final double hight;
  final double width;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        return tournamentCover(imageProvider);
      },
      placeholder: (context, url) => const Center(
        child: SpinKitThreeBounce(
          color: AppColors.primary,
          size: 50,
        ),
      ),
      errorWidget: (context, url, error) =>  tournamentCover(
         const AssetImage(
          AppProfilesCover.tournamentCover,
        ),
      ),
    );
  }

  Container tournamentCover(ImageProvider<Object> imageProvider) {
    return Container(
      height: hight,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppRadius.borderRadiusS,
          ),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: imageProvider,
        ),
      ),
    );
  }
}
