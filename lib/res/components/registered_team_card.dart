import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class RegisteredTeamCard extends StatelessWidget {
  const RegisteredTeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black,width: 0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      height: 60,
      width: size.width *0.333,
      child: Row(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              color: AppColors.white,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                    "assets/images/pexels-francesco-paggiaro-705794.jpg"),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child:  Text(
                "Test Club",style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
