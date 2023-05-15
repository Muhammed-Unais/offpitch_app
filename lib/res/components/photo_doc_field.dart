
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class PhotoDocfield extends StatelessWidget {
  const PhotoDocfield(
      {super.key,
      required this.textOfPdf,
      required this.imagefunction,
      required this.docfunction,
      this.image,
      this.docName,
      this.border,
      this.isCreate = true,
      this.docBorder});

  final String textOfPdf;
  final void Function()? imagefunction;
  final void Function()? docfunction;
  final String? image;
  final String? docName;
  final BoxBorder? border;
  final BoxBorder? docBorder;
  final bool isCreate;

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
                border: border,
                image: image != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(image!)
                      )
                    : null,
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                IconlyBold.camera,
                color: AppColors.black,
              ),
            ),
          ),
        ),
        isCreate
            ? Expanded(
                flex: 3,
                child: InkWell(
                  onTap: docfunction,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    constraints:
                        const BoxConstraints.expand(height: double.infinity),
                    decoration: BoxDecoration(
                      border: docBorder,
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        docName != null ? docName! : textOfPdf,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
            : const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
      ],
    );
  }
}
