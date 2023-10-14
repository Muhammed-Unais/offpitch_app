import 'package:flutter/material.dart';

class DetaislViewAppBar extends StatelessWidget {
  const DetaislViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}
