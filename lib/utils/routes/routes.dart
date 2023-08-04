import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view/explore_view/explore_view.dart';
import 'package:offpitch_app/view/home_view/home_view.dart';
import 'package:offpitch_app/view/login_view/login_view.dart';
import 'package:offpitch_app/view/bottom_bar_view/navigation_bar_view.dart';
import 'package:offpitch_app/view/my_club_view/club_creation_view/club_creation_view.dart';
import 'package:offpitch_app/view/my_club_view/my_club_view.dart';
import 'package:offpitch_app/view/otp_verify_view/otp_verify_view.dart';
import 'package:offpitch_app/view/signup_view/signup_view.dart';
import 'package:offpitch_app/view/splash_view.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_registration_payment_success_view.dart';
import 'package:offpitch_app/view/tournament_details_view/torunament_details_view.dart';
import 'package:offpitch_app/view/user_profile_view/user_watch_list_view/user_watch_list.dart';

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
          builder: (context) =>const MyClubView(),
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
        return MaterialPageRoute(
          builder: (context) {
            return const PaymentStatusScreen();
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
