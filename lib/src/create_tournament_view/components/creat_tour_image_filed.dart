import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/create_tournament_view/view_model/create_tournament_view_model.dart';
import 'package:provider/provider.dart';

class CreateTournamentImagefield extends StatelessWidget {
  const CreateTournamentImagefield({super.key, required this.border});

  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final createTorunamentViewModel =
        Provider.of<CreateTournamentViewModel>(context);
    return Container(
      height: size.height * 0.14,
      width: size.width,
      margin: const EdgeInsets.only(
         left: 20,right: 20,bottom: 20),
      child: InkWell(
        onTap: () async {
          await createTorunamentViewModel.getImageFromGallery();
        },
        child: Container(
          constraints: const BoxConstraints.expand(height: double.infinity),
          decoration: BoxDecoration(
            border: border,
            image: createTorunamentViewModel.images != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      createTorunamentViewModel.images!,
                    ),
                  )
                : null,
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppRadius.borderRadiusS),
          ),
          child: createTorunamentViewModel.images == null
              ? const Icon(
                  IconlyBold.camera,
                  color: AppColors.black,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
