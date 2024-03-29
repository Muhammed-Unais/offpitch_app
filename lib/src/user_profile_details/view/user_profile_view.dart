import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/user_profile_details/widgets/user_profile_about_us_expansion.dart';
import 'package:offpitch_app/src/user_profile_details/widgets/user_profile_club_card.dart';
import 'package:offpitch_app/src/user_profile_details/widgets/user_profile_settings_expansion.dart';
import 'package:offpitch_app/src/user_profile_details/widgets/user_profile_wallet_card.dart';
import 'package:offpitch_app/src/user_profile_details/widgets/user_profile_watchlist_expansion.dart';
import 'package:offpitch_app/src/user_profile_details/view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';
import '../../splash/view_model/user_view_model.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  void initState() {
    var userClubId = context.read<UserViewModel>().userClubId;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userClubId ?? context.read<UserViewModel>().getUserClubId();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<UserProfileViewModel>(builder: (context, userProvider, _) {
      var data = userProvider.userProfileResponse.data?.data;
      return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(
              left: AppMargin.small,
            ),
            child: Text(
              "Hi, ${data?.name?.toUpperCase() ?? "WELCOME"}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 14,
                backgroundImage:
                    data?.profile == null ? null : NetworkImage(data!.profile!),
              ),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right:20,
          ),
          child: Consumer<UserProfileViewModel>(
            builder: (context, value, _) {
              switch (value.userProfileResponse.status) {
                case Status.LOADING:
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  );
                case Status.COMPLETED:
                  final data = value.userProfileResponse.data?.data;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserProfileClubCard(
                          clubCover: data?.club?.profile,
                          clubName: data?.club?.name,
                          clubStatus: data?.club?.status,
                          playersCount: data?.club?.players,
                        ),
                        UserProfileWalletCard(walletAmount: data?.wallet),
                        const SizedBox(height: 20,),
                        const Divider(
                          height: 0.2,
                          color: AppColors.grey,
                        ),
                        const UserProfileWatchListExpansion(),
                        const UserProfileSettingsExpansion(),
                        const UserProfileAboutUsExpansion(),
                      ],
                    ),
                  );
                case Status.ERROR:
                  return Center(
                    child: ErrorComponent(
                      width: size.height * 0.15,
                      hight: size.height * 0.15,
                      errorMessage: value.userProfileResponse.message ?? "",
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      );
    });
  }
}
