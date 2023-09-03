
import 'package:flutter/material.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/explore_view_view_model.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/home_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/create_new_club_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_player_add_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:offpitch_app/view_model/user_profile_view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';
import 'create_tournament_view_model/create_tournament_view_model.dart';
import 'tournament_details_view_model.dart/registration_view_model.dart';

class LogoutViewModel extends ChangeNotifier {
  clearAllDatasLogout(BuildContext context) {
    Provider.of<HomeViewModel>(context, listen: false)
        .clearAllDataLogout();
    Provider.of<ExploreViewViewModel>(context, listen: false)
        .clearAllDataLogout();
    Provider.of<DetailsTouramentViewModel>(context, listen: false)
        .clearAlldataLogout();
    Provider.of<CreateNewClubViewModel>(context, listen: false)
        .clearAllDataLogout();
    Provider.of<MyClubViewModel>(context, listen: false).clearAllDateLogout();
    Provider.of<RegistorationViewModel>(context, listen: false)
        .clearAllDataLogout();
    Provider.of<MyClubPlayerAddViewModel>(context, listen: false)
        .clearAllDataLogout();
    Provider.of<CreateTournamentViewModel>(context, listen: false)
        .clearAllDataLogout();
    Provider.of<UserProfileViewModel>(context, listen: false)
        .clearAlldataLogout();    
  }
}
