import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';

class DoyouhaveAcc extends StatelessWidget {
  const DoyouhaveAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.signup);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Dont have an account? ",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "Sign up",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
