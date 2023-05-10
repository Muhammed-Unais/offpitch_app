import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/circle_images.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view_model/my_club_view_model/create_new_club_view_model.dart';
import 'package:provider/provider.dart';

class TabViewOneClubProfile extends StatelessWidget {
  const TabViewOneClubProfile({
    super.key,
    required this.image,
    required this.clubName,
    required this.playerCount,
  });

  final String image;
  final String clubName;
  final int playerCount;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final clubcreatNewViewModel =
        Provider.of<CreateNewClubViewModel>(context, listen: false);
    return Container(
      height: size.height * 0.1,
      margin: const EdgeInsetsDirectional.symmetric(
        vertical: AppMargin.medium,
        horizontal: AppMargin.large,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CircleImages(
              image: image,
              radius: 60,
            ),
          ),
          const SizedBox(width: AppMargin.medium,),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clubName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "Players:$playerCount",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                clubcreatNewViewModel.setOptions(false);
                clubcreatNewViewModel.editValueAssaignFunc(context);
                Navigator.pushNamed(context, RoutesName.clubCreation);
              },
              child: const Icon(
                Icons.edit_square,
                color: AppColors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
