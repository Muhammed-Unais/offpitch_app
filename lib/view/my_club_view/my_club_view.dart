import 'package:flutter/material.dart';

class MyClubView extends StatelessWidget {
  const MyClubView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "My Club view",
            ),
          ),
        ],
      ),
    );
  }
}