import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/photo_doc_field.dart';
import 'package:offpitch_app/res/components/textformfied_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/my_club_view_model.dart';
import 'package:provider/provider.dart';

class AddPlayerBottomSheet {
  static showBottomAddPlayer(
    context,
  ) {
    final myClubprovider = Provider.of<MyClubViewModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(

          child: Container(
            // height: size.height * 0.75,
            padding:  EdgeInsets.only(
              left: AppPadding.large,
              right: AppPadding.large,
              top: AppPadding.large,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add a Player",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: AppMargin.large),
                  height: size.height * 0.16,
                  width: size.width * 0.75,
                  child: PhotoDocfield(
                    isCreate: true,
                    docName: myClubprovider.docName,
                    border: myClubprovider.border,
                    image: myClubprovider.images,
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
                  type: TextInputType.name,
                  hintText: "Name",
                  maxLines: null,
                  controller: myClubprovider.controllerName,
                  currentFocusNode: myClubprovider.focusNodeName,
                  nextFocusNode: myClubprovider.focusNodeDob,
                ),
                const SizedBox(height: AppMargin.large),
                TextFormFieldsComponent(
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
                      onPressed: () {
                        
                      },
                      child: const Text(
                        "Save & Continue",
                      ),
                    ),
                  ),
                ),
                 const SizedBox(height: AppMargin.large),
              ],
            ),
          ),
        );
      },
    );
  }
}
