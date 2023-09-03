import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/user_profile_view/widgets/user_profile_about_us_expansion.dart';
import 'package:offpitch_app/view/user_profile_view/widgets/user_profile_club_card.dart';
import 'package:offpitch_app/view/user_profile_view/widgets/user_profile_settings_expansion.dart';
import 'package:offpitch_app/view/user_profile_view/widgets/user_profile_wallet_card.dart';
import 'package:offpitch_app/view/user_profile_view/widgets/user_profile_watchlist_expansion.dart';
import 'package:offpitch_app/view_model/user_profile_view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileViewModel>(builder: (context, userProvider, _) {
      var data = userProvider.userProfileResponse.data?.data;
      return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(
              left: AppMargin.small,
            ),
            child: Text(
              "Hi,${data?.name}",
            ),
          ),
          centerTitle: false,
          actions: [
            CircleAvatar(
              radius: 16,
              backgroundImage: data?.profile == null
                  ? null
                  : NetworkImage(data!.profile!),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(
            left: AppMargin.large,
            right: AppMargin.large,
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
                        Text(
                          "Your Club",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        UserProfileClubCard(
                          clubCover: data?.club?.profile,
                          clubName: data?.club?.name,
                          clubStatus: data?.club?.status,
                          playersCount: data?.club?.players,
                        ),
                        UserProfileWalletCard(walletAmount: data?.wallet),
                        const Divider(
                          height: 0.5,
                          color: AppColors.black,
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
