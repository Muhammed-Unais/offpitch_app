import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:offpitch_app/view_model/bottom_bar_viewmodel.dart';
import 'package:provider/provider.dart';

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final userAuthModel = Provider.of<UserViewModel>(context);
    final userAuthviewModel = Provider.of<AuthViewModel>(context);
    final bottomviewModel = Provider.of<BottomBarViewModel>(context);

    return AlertDialog(
      title: const Text('Logout'),
      content: Text(
        'Are you sure you want to logout?',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        TextButton(
          onPressed: () {
            userAuthviewModel.userlogout();
            userAuthModel.remove();
            // userAuthModel.club();
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.login,
              (route) => false,
            ); // Close the dialog
            bottomviewModel.onTap(0, context);
          },
          child: const Text(
            'Logout',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
