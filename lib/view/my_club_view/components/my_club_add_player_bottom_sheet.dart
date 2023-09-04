import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/photo_doc_field.dart';
import 'package:offpitch_app/res/components/textformfied_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_player_add_view_model.dart';
import 'package:offpitch_app/view_model/services.dart/add_player_validation/add_player_validation.dart';
import 'package:provider/provider.dart';

class AddPlayerBottomSheet {
  static showBottomAddPlayer(context) {
    final size = MediaQuery.of(context).size;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (context) => MyClubPlayerAddViewModel(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: AppPadding.large,
                right: AppPadding.large,
                top: AppPadding.large,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: formKey,
                child: Consumer<MyClubPlayerAddViewModel>(
                    builder: (context, myClubprovider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add new player",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: AppMargin.large),
                        height: size.height * 0.16,
                        width: size.width * 0.75,
                        child: PhotoDocfield(
                          isCreate: true,
                          docBorder: myClubprovider.pdfborder,
                          docName: myClubprovider.docName,
                          border: myClubprovider.border,
                          image: myClubprovider.imageUrl,
                          docfunction: () {
                            myClubprovider.getGovtRegfiles();
                          },
                          imagefunction: () {
                            myClubprovider.getProfileFromGallery();
                          },
                          textOfPdf: "Pdf of Age Proof",
                        ),
                      ),
                      TextFormFieldsComponent(
                        validator: AddplayerValidation.nameValidation,
                        hintText: "Name",
                        maxLines: null,
                        controller: myClubprovider.controllerName,
                        currentFocusNode: myClubprovider.focusNodeName,
                        nextFocusNode: myClubprovider.focusNodeDob,
                      ),
                      const SizedBox(height: AppMargin.large),
                      TextFormFieldsComponent(
                        validator: AddplayerValidation.dobValidation,
                        onTap: () {
                          myClubprovider.showDatePickerforDate(context);
                        },
                        type: TextInputType.none,
                        isOutfoucsNode: true,
                        hintText: "Date of Birth",
                        maxLines: null,
                        controller: myClubprovider.controllerDob,
                        currentFocusNode: myClubprovider.focusNodeDob,
                        nextFocusNode: myClubprovider.focusNodeDob,
                      ),
                      const SizedBox(height: AppMargin.large),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate() &&
                                  myClubprovider.imageUrl != null &&
                                  myClubprovider.docName != null) {
                                await myClubprovider.postPlayers(context);
                              } else if (myClubprovider.imageUrl == null) {
                                myClubprovider.setBorderError(
                                    Border.all(color: Colors.red));
                              } else if (myClubprovider.docName == null) {
                                myClubprovider.setDocBorderError(
                                    Border.all(color: Colors.red));
                              }
                            },
                            child: myClubprovider.plyerAddSaveAndContinue
                                ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 1,
                                  )
                                : const Text(
                                    "Save & Continue",
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppMargin.large),
                    ],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
