import 'package:flutter/material.dart';

class AlreadyHaveAcc extends StatelessWidget {
  const AlreadyHaveAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "Login",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
