import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/photo_doc_field.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/create_new_club_view_model.dart';
import 'package:provider/provider.dart';

class ClubCreationPhotoDoc extends StatelessWidget {
  const ClubCreationPhotoDoc(
      {super.key, required this.imagefunction, required this.docfunction, this.image});

  final void Function() imagefunction;
  final void Function() docfunction;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final clubCreateProvider =Provider.of<CreateNewClubViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.15,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.large,
        vertical: AppMargin.large,
      ),
      child: PhotoDocfield(
        isCreate: clubCreateProvider.isCreate,
        docfunction:imagefunction,
        imagefunction:docfunction,
        textOfPdf: "Pdf of govt registration",
      ),
    );
  }
}
