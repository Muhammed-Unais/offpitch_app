import 'package:flutter/material.dart';
import 'package:offpitch_app/src/my_club_view/components/tav_view_one_email_phone.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:readmore/readmore.dart';

class TabViewOneClubDescription extends StatelessWidget {
  const TabViewOneClubDescription({
    super.key,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.phone,
  });

  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String email;
  final int phone;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
          const SizedBox(height: 20,),
          TabbarViewOneEmailPhone(
            hight: size.height * 0.08,
            email: email,
            phone: phone,
          ),
        ],
      ),
    );
  }
}
