import 'package:flutter/material.dart';
import 'package:offpitch_app/src/bottom_bar/navigation_bar_view.dart';
import 'package:offpitch_app/src/create_tournament/view/create_tournament_view.dart';
import 'package:offpitch_app/src/explore/view/explore_search_view.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/src/explore/view/explore_view.dart';
import 'package:offpitch_app/src/home/view/home_view.dart';
import 'package:offpitch_app/src/login/view/login_view.dart';
import 'package:offpitch_app/src/club_creation/view/club_creation_view.dart';
import 'package:offpitch_app/src/my_club_details/view/my_club_view.dart';
import 'package:offpitch_app/src/otp_verify/view/otp_verify_view.dart';
import 'package:offpitch_app/src/signup/view/signup_view.dart';
import 'package:offpitch_app/src/splash/view/splash_view.dart';
import 'package:offpitch_app/src/tournament_details/components/registration_components/payment_status_screen.dart';
import 'package:offpitch_app/src/tournament_details/view/torunament_details_view.dart';
import 'package:offpitch_app/src/user_watch_list/view/user_watch_list.dart';

class Routes {
  static Route<dynamic> genericRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (context) => const SignupView(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );
      case RoutesName.tournamentHost:
        return MaterialPageRoute(
          builder: (context) => const CreateTournamentView(),
        );
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RoutesName.otp:
        return MaterialPageRoute(
          builder: (context) => const OtpVerifyView(),
        );
      case RoutesName.navigation:
        return MaterialPageRoute(
          builder: (context) => const BottomBarView(),
        );
      case RoutesName.explore:
        return MaterialPageRoute(
          builder: (context) => const ExploreView(),
        );
      case RoutesName.tournamentDetails:
        return MaterialPageRoute(
          builder: (context) => const TouranmentDetailsView(),
        );
      case RoutesName.myClub:
        return MaterialPageRoute(
          builder: (context) => const MyClubView(),
        );
      case RoutesName.clubCreation:
        return MaterialPageRoute(
          builder: (context) => const ClubCreationView(),
        );
      case RoutesName.userWatchlist:
        return MaterialPageRoute(
          builder: (context) => const UserWatchListView(),
        );
      case RoutesName.searchScreen:
        return MaterialPageRoute(
          builder: (context) => const ExploreSearchView(),
        );
      case RoutesName.paymentSuccespage:
        var args = settings.arguments as List<dynamic>;
        String tournamentId = args[0];
        bool status= args[1];
        return MaterialPageRoute(
          builder: (context) {
            return PaymentStatusScreen(
              tournamentId: tournamentId,
              isSuccess: status,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text(
                "No route defined",
              ),
            ),
          ),
        );
    }
  }
}
