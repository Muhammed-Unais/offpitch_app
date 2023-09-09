import 'package:flutter/material.dart';
import 'package:offpitch_app/view/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/view/home_view/view_model/home_view_model.dart';
import 'package:offpitch_app/view/club_creation_view/view_model/create_new_club_view_model.dart';
import 'package:offpitch_app/view/my_club_view/view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/view/my_club_view/view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:offpitch_app/view/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/view/user_profile_view/view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class LogoutViewModel extends ChangeNotifier {
  void clearAllDatasLogout(BuildContext context) {
    context.read<HomeViewModel>().clearAllDataLogout();
    context.read<ExploreViewViewModel>().clearAllDataLogout();
    context.read<DetailsTouramentViewModel>().clearAlldataLogout();
    context.read<CreateNewClubViewModel>().clearAllDataLogout();
    context.read<MyClubViewModel>().clearAllDateLogout();
    context.read<UserProfileViewModel>().clearAlldataLogout();
    context.read<UserHostRegTournamentViewModel>().clearAllDataLogout();
  }
}
