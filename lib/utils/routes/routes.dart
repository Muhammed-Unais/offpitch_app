import 'package:flutter/material.dart';
import 'package:offpitch_app/features/create_tournament_view/create_tournament_view.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/features/explore_view/explore_view.dart';
import 'package:offpitch_app/features/home_view/home_view.dart';
import 'package:offpitch_app/features/login_view/login_view.dart';
import 'package:offpitch_app/features/bottom_bar_view/navigation_bar_view.dart';
import 'package:offpitch_app/features/club_creation_view/club_creation_view.dart';
import 'package:offpitch_app/features/my_club_view/my_club_view.dart';
import 'package:offpitch_app/features/otp_verify_view/otp_verify_view.dart';
import 'package:offpitch_app/features/signup_view/signup_view.dart';
import 'package:offpitch_app/features/splash_screen/splash_view.dart';
import 'package:offpitch_app/features/tournament_details_view/components/details_view_registration_payment_success_view.dart';
import 'package:offpitch_app/features/tournament_details_view/torunament_details_view.dart';
import 'package:offpitch_app/features/user_watch_list_view/user_watch_list.dart';

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
        var query = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ExploreView(searchQuery: query),
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
