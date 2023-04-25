import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class PhotoDocfield extends StatelessWidget {
  const PhotoDocfield(
      {super.key,
      required this.textOfPdf,
      required this.imagefunction,
      required this.docfunction,
      this.image,this.docName});

  final String textOfPdf;
  final void Function() imagefunction;
  final void Function() docfunction;
  final String? image;
  final String? docName;

  @override
  Widget build(BuildContext context) {
    return Row( 
      children: [
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: imagefunction,
            child: Container(
              constraints: const BoxConstraints.expand(height: double.infinity),
              margin: const EdgeInsets.only(
                right: AppMargin.medium,
              ),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                IconlyBold.camera,
                color: AppColors.black,
              ),
            ),
          ),
        ), 
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: docfunction,
            child: Container(
              constraints: const BoxConstraints.expand(height: double.infinity),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  textOfPdf,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
