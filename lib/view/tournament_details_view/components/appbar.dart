import 'package:flutter/material.dart';

class DetaislViewAppBar extends StatelessWidget {
  const DetaislViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_forward,
          ),
        )
      ],
    );
  }
}