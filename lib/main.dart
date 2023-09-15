import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/routes/routes.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/features/login_view/view_model/auth_view_model.dart';
import 'package:offpitch_app/features/bottom_bar_view/view_model/bottom_bar_viewmodel.dart';
import 'package:offpitch_app/features/home_view/view_model/home_view_model.dart';
import 'package:offpitch_app/features/user_profile_view/view_model/logout_view_model.dart';
import 'package:offpitch_app/features/club_creation_view/view_model/create_new_club_view_model.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/features/my_club_view/view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/view_model/schedule_tournament_view_model.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/features/splash_screen/view_model/user_view_model.dart';
import 'package:offpitch_app/features/user_profile_view/view_model/user_profile_view_model.dart';
import 'package:provider/provider.dart';
import 'features/my_club_view/view_model/my_club_over_view_model.dart';

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
          create: (context) => LogoutViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserHostRegTournamentViewModel(),
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
