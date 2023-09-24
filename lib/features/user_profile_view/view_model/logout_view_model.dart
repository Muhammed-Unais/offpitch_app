import 'package:flutter/material.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/features/club_creation_view/view_model/create_new_club_view_model.dart';
import 'package:offpitch_app/features/my_club_view/view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/features/my_club_view/view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/features/user_profile_view/view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class LogoutViewModel extends ChangeNotifier {
  void clearAllDatasLogout(BuildContext context) {
    context.read<ExploreViewViewModel>().clearAllDataLogout();
    context.read<DetailsTouramentViewModel>().clearAlldataLogout();
    context.read<CreateNewClubViewModel>().clearAllDataLogout();
    context.read<MyClubViewModel>().clearAllDateLogout();
    context.read<UserProfileViewModel>().clearAlldataLogout();
    context.read<UserHostRegTournamentViewModel>().clearAllDataLogout();
  }
}
