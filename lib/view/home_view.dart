import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefrence = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Home Screen",
            ),
          ),
          TextButton(
            onPressed: () {
              userPrefrence.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}
