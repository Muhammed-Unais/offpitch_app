import 'package:flutter/material.dart';
import 'package:offpitch_app/src/explore/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/src/club_creation/view_model/create_new_club_view_model.dart';
import 'package:offpitch_app/src/my_club_details/view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/src/my_club_details/view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:offpitch_app/src/tournament_details/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/src/user_profile_details/view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class LogoutViewModel {
  void clearAllDatasLogout(BuildContext context) {
    context.read<ExploreViewViewModel>().clearAllDataLogout();
    context.read<DetailsTouramentViewModel>().clearAlldataLogout();
    context.read<CreateNewClubViewModel>().clearAllDataLogout();
    context.read<MyClubViewModel>().clearAllDateLogout();
    context.read<UserProfileViewModel>().clearAlldataLogout();
    context.read<UserHostRegTournamentViewModel>().clearAllDataLogout();
  }
}
