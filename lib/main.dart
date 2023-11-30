import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/bottom_bar/view_model/bottom_bar_viewmodel.dart';
import 'package:offpitch_app/src/explore/view_model/explore_search_view_model.dart';
import 'package:offpitch_app/utils/routes/routes.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/src/login/view_model/auth_view_model.dart';
import 'package:offpitch_app/src/home/view_model/home_view_model.dart';
import 'package:offpitch_app/src/club_creation/view_model/create_new_club_view_model.dart';
import 'package:offpitch_app/src/explore/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/src/my_club_details/view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:offpitch_app/src/tournament_schedule.dart/view_model/schedule_tournament_view_model.dart';
import 'package:offpitch_app/src/tournament_details/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/src/splash/view_model/user_view_model.dart';
import 'package:offpitch_app/src/user_profile_details/view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';
import 'src/my_club_details/view_model/my_club_over_view_model.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyClubViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomBarViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailsTouramentViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateNewClubViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExploreViewViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleTournametViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserHostRegTournamentViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExploreSearchViewModel(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Offpitch',
        theme: AppTheme.lightTheme,
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.genericRoute,
      ),
    );
  }
}
