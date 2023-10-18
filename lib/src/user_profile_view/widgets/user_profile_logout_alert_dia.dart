import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/splash_screen/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final userAuthModel = Provider.of<UserViewModel>(context);
    return AlertDialog(
      
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      title: const Text(
        'Logout',
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Lato",
          color: AppColors.black,
        ),
      ),
      content: const Text(
        'Are you sure you want to logout?',
        style: TextStyle(
          fontSize: 12,
          fontFamily: "Lato",
          color: AppColors.black,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await userAuthModel.logoutRemoveAllData(context);
          },
          child: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Lato",
              color: AppColors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Lato",
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
