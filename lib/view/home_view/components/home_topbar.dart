import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HommeTopBar extends StatelessWidget {
  const HommeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userAuthModel = Provider.of<UserViewModel>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: AppMargin.large, right: AppMargin.large),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                color: AppColors.white,
                onPressed: () {
                  userAuthModel.remove();
                  // userAuthModel.club();
                  Navigator.pushNamedAndRemoveUntil(context, RoutesName.login,(route) => false,);
                },
                icon: const Icon(
                  Icons.notifications,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
