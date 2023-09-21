import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:readmore/readmore.dart';

class TabViewOneClubDescription extends StatelessWidget {
  const TabViewOneClubDescription({
    super.key,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.grey, width: 0.2),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadMoreText(
              description,
              style: const TextStyle(
                fontFamily: "SFUIDisplay",
                fontSize: 12,
                color: AppColors.black,
              ),
              textAlign: TextAlign.justify,
              trimMode: TrimMode.Line,
              trimLines: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                children: [
                  
                  const TextSpan(
                    text: "Created date:- ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SFUIDisplay",
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  ),
                  TextSpan(
                    text: createdAt.toString().split(" ").first,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "SFUIDisplay",
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Updated date:- ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SFUIDisplay",
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  ),
                  TextSpan(
                    text: updatedAt.toString().split(" ").first,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "SFUIDisplay",
                      fontSize: 12,
                      color: AppColors.black,
                    ),
                  )
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
