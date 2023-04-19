import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/photo_doc_field.dart';
import 'package:offpitch_app/res/constats.dart';

class ClubCreationPhotoDoc extends StatelessWidget {
  const ClubCreationPhotoDoc(
      {super.key, required this.imagefunction, required this.docfunction});

  final void Function() imagefunction;
  final void Function() docfunction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.15,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.large,
        vertical: AppMargin.large,
      ),
      child: PhotoDocfield(
        docfunction:imagefunction,
        imagefunction:docfunction,
        textOfPdf: "Pdf of govt registration",
      ),
    );
  }
}
