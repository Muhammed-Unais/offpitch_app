import 'package:flutter/material.dart';
import 'package:offpitch_app/view/my_club_view/club_creation_view/components/club_creation_name_email_phone.dart';
import 'package:offpitch_app/view/my_club_view/club_creation_view/components/club_creation_photo_doc.dart';
import 'package:offpitch_app/view/my_club_view/club_creation_view/components/club_creation_save_button.dart';
import 'package:offpitch_app/view_model/my_club_view_model/create_new_club_view_model.dart';
import 'package:offpitch_app/view_model/services.dart/club_creation_valdation.dart/club_creation_validation.dart';
import 'package:provider/provider.dart';

class ClubCreationBody extends StatelessWidget {
  const ClubCreationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final clubcreatNewViewModel = Provider.of<CreateNewClubViewModel>(context);
    final formkey = GlobalKey<FormState>();
    return Column(
      children: [
        ClubCreationPhotoDoc(
          docfunction: () {
            clubcreatNewViewModel.getImageFromGallery();
          },
          imagefunction: () {
            clubcreatNewViewModel.getGovtRegfiles();
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formkey,
                  child: ClubCreationNameEmailPhone(
                    nameValidator: (value) =>
                        ClubCreationValidation.nameValidaton(value),
                    emailValidator: (value) =>
                        ClubCreationValidation.emailValidation(value),
                    phomeValidator: (value) =>
                        ClubCreationValidation.phoneValidation(value),
                    descValidator: (value) =>
                        ClubCreationValidation.discrptionValidation(value),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ClubCreationSaveButton(
                  processLoading: clubcreatNewViewModel.updateIsLoading,
                  buttonText:
                      !clubcreatNewViewModel.isCreate ? "Update" : "Save",
                  width: size.width * 0.4,
                  btnFunction: () async {
                    if (formkey.currentState!.validate()) {
                      clubcreatNewViewModel.isCreate
                          ?await clubcreatNewViewModel.saveButtonFunc(context)
                          :await clubcreatNewViewModel.updateFunc(context);  
                    }
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
