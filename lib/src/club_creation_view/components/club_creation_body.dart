import 'package:flutter/material.dart';
import 'package:offpitch_app/src/club_creation_view/components/club_creation_name_email_phone.dart';
import 'package:offpitch_app/src/club_creation_view/components/club_creation_photo_doc.dart';
import 'package:offpitch_app/src/club_creation_view/components/club_creation_save_button.dart';
import 'package:offpitch_app/src/club_creation_view/view_model/create_new_club_view_model.dart';
import 'package:offpitch_app/res/common/services.dart/club_creation_valdation.dart/club_creation_validation.dart';
import 'package:provider/provider.dart';

class ClubCreationBody extends StatelessWidget {
  const ClubCreationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formkey = GlobalKey<FormState>();
    return Column(
      children: [
        ClubCreationPhotoDoc(
          docfunction: () {
            context.read<CreateNewClubViewModel>().getImageFromGallery();
          },
          imagefunction: () {
            context.read<CreateNewClubViewModel>().getGovtRegfiles();
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formkey,
                  child: const ClubCreationNameEmailPhone(
                    nameValidator: ClubCreationValidation.nameValidaton,
                    emailValidator: ClubCreationValidation.emailValidation,
                    phomeValidator: ClubCreationValidation.phoneValidation,
                    descValidator: ClubCreationValidation.discrptionValidation,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Consumer<CreateNewClubViewModel>(
                  builder: (context, createNewClubViewModelProvider, _) {
                    return ClubCreationSaveButton(
                      processLoading:
                          createNewClubViewModelProvider.updateIsLoading,
                      buttonText: !createNewClubViewModelProvider.isCreate
                          ? "Update"
                          : "Save",
                      width: size.width * 0.4,
                      btnFunction: () async {
                        if (formkey.currentState!.validate()) {
                          final clubcreatNewViewModel =
                              context.read<CreateNewClubViewModel>();

                          createNewClubViewModelProvider.isCreate
                              ? await clubcreatNewViewModel
                                  .saveButtonFunc(context)
                              : await clubcreatNewViewModel.updateFunc(context);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
