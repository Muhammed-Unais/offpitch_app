import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/photo_doc_field.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/club_creation_view/view_model/create_new_club_view_model.dart';
import 'package:provider/provider.dart';

class ClubCreationPhotoDoc extends StatelessWidget {
  const ClubCreationPhotoDoc(
      {super.key, required this.imagefunction, required this.docfunction, this.image});

  final void Function() imagefunction;
  final void Function() docfunction;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final clubCreateProvider =context.watch<CreateNewClubViewModel>();
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.15,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.large,
        vertical: AppMargin.large,
      ),
      child: PhotoDocfield(
        docName: clubCreateProvider.docname,
        image: clubCreateProvider.imageUrl,
        isCreate: clubCreateProvider.isCreate,
        docfunction:imagefunction,
        imagefunction:docfunction,
        textOfPdf: "Pdf of govt registration",
      ),
    );
  }
}
