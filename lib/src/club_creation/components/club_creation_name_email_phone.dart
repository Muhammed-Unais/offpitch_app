import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/textformfied_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/club_creation/view_model/create_new_club_view_model.dart';
import 'package:provider/provider.dart';

class ClubCreationNameEmailPhone extends StatefulWidget {
  const ClubCreationNameEmailPhone(
      {super.key,
      this.nameValidator,
      this.emailValidator,
      this.phomeValidator,  
      this.descValidator});

  final String? Function(String?)? nameValidator,
      emailValidator,
      phomeValidator,
      descValidator;

  @override
  State<ClubCreationNameEmailPhone> createState() => _ClubCreationNameEmailPhoneState();
}

class _ClubCreationNameEmailPhoneState extends State<ClubCreationNameEmailPhone> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final clubcreatNewViewModel = Provider.of<CreateNewClubViewModel>(context);
    return Container(
      height: size.height * 0.5,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: Column(
        children: [
          Expanded(
            child: TextFormFieldsComponent(
              type: TextInputType.name,
              nextFocusNode: clubcreatNewViewModel.emailFoucsNode,
              currentFocusNode: clubcreatNewViewModel.nameFoucsNode,
              validator: widget.nameValidator,
              controller: clubcreatNewViewModel.nameController,
              hintText: "Name",
              maxLines: null,
            ),
          ),
          Expanded(
            child: TextFormFieldsComponent(
              type: TextInputType.emailAddress,
              currentFocusNode: clubcreatNewViewModel.emailFoucsNode,
              nextFocusNode: clubcreatNewViewModel.phoneFoucusNode,
              validator: widget.emailValidator,
              controller: clubcreatNewViewModel.emailController,
              hintText: "Email",
              maxLines: null,
            ),
          ),
          Expanded(
            child: TextFormFieldsComponent(
              type: TextInputType.phone,
              currentFocusNode: clubcreatNewViewModel.phoneFoucusNode,
              nextFocusNode: clubcreatNewViewModel.descriptionFoucusNode,
              validator: widget.phomeValidator,
              controller: clubcreatNewViewModel.phoneController,
              hintText: "Phone",
              maxLines: null,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormFieldsComponent(
              type: TextInputType.multiline,
              isOutfoucsNode: true,
              currentFocusNode: clubcreatNewViewModel.descriptionFoucusNode,
              nextFocusNode: clubcreatNewViewModel.descriptionFoucusNode,
              validator: widget.descValidator,
              controller: clubcreatNewViewModel.descriptionController,
              hintText: "Description",
              maxLines: 8,
            ),
          ),
        ],
      ),
    );
  }
}
