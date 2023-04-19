import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:readmore/readmore.dart';

class TabViewOneClubDescription extends StatelessWidget {
  const TabViewOneClubDescription(
      {super.key, required this.hight, required this.width, required this.description, required this.phone, required this.email});

  final double hight;
  final double width;
  final String description;
  final String email;
  final int phone;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReadMoreText(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.start,
            trimMode: TrimMode.Line,
            trimLines: 5,
          ),
          SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.messenger_outline_rounded,
                      color: AppColors.grey,
                      size: 18,
                    ),
                    Text(
                     email,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
                const SizedBox(height: AppPadding.small,),
                Row(
                  children: [
                    const Icon(
                      size: 18,
                      Icons.call_outlined,
                      color: AppColors.grey,
                    ),
                    Text(
                      phone.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                 const SizedBox(height: AppPadding.medium,),
                const Divider(thickness: 0.5,color: AppColors.grey,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
