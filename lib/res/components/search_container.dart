import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightgrey,
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: AppColors.black,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "Search by tournaments,place and club",
            style: TextStyle(
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.none,
              fontSize: 12,
              fontFamily: "SFUIDisplay",
              color: AppColors.grey,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
