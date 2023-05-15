import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/textformfied_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/create_tournament_view_model/create_tournament_view_model.dart';
import 'package:provider/provider.dart';

class CreateTournamentfirstFields extends StatelessWidget {
  const CreateTournamentfirstFields(
      {super.key,
      this.dateValidator,
      this.locationValidator,
      this.titleValidator,
      this.descValidator,
      this.aboutValidator});

  final String? Function(String?)? dateValidator,
      locationValidator,
      titleValidator,
      descValidator,
      aboutValidator;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tournamentcreatNewViewModel =
        Provider.of<CreateTournamentViewModel>(context);
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: Column(
        children: [
          TextFormFieldsComponent(
            type: TextInputType.none,
            onTap: () async {
              tournamentcreatNewViewModel.datePickerinTextfield(context);
            },
            nextFocusNode: tournamentcreatNewViewModel.locationFoucsNode,
            currentFocusNode: tournamentcreatNewViewModel.dateFoucsNode,
            validator: dateValidator,
            controller: tournamentcreatNewViewModel.dateController,
            hintText: "Starting Date",
            maxLines: null,
          ),
          const SizedBox(
            height: AppMargin.medium,
          ),
          TextFormFieldsComponent(
            type: TextInputType.name,
            currentFocusNode: tournamentcreatNewViewModel.locationFoucsNode,
            nextFocusNode: tournamentcreatNewViewModel.titleFoucusNode,
            validator: locationValidator,
            controller: tournamentcreatNewViewModel.locationController,
            hintText: "Location",
            maxLines: null,
          ),
          const SizedBox(
            height: AppMargin.medium,
          ),
          TextFormFieldsComponent(
            type: TextInputType.name,
            currentFocusNode: tournamentcreatNewViewModel.titleFoucusNode,
            nextFocusNode: tournamentcreatNewViewModel.descriptionFoucusNode,
            validator: titleValidator,
            controller: tournamentcreatNewViewModel.titleTorurnamentController,
            hintText: "Title of tournament",
            maxLines: null,
          ),
          const SizedBox(
            height: AppMargin.medium,
          ),
          TextFormFieldsComponent(
            type: TextInputType.multiline,
            currentFocusNode: tournamentcreatNewViewModel.descriptionFoucusNode,
            nextFocusNode: tournamentcreatNewViewModel.aboutFoucusNode,
            validator: descValidator,
            controller: tournamentcreatNewViewModel.descriptionController,
            hintText: "Brief Description",
            maxLines: 4,
          ),
          const SizedBox(
            height: AppMargin.medium,
          ),
          TextFormFieldsComponent(
            type: TextInputType.multiline,
            isOutfoucsNode: true,
            currentFocusNode: tournamentcreatNewViewModel.aboutFoucusNode,
            nextFocusNode: tournamentcreatNewViewModel.aboutFoucusNode,
            validator: aboutValidator,
            controller: tournamentcreatNewViewModel.aboutController,
            hintText: "About the tournament",
            maxLines: 7,
          ),
          const SizedBox(
            height: AppMargin.medium,
          ),
        ],
      ),
    );
  }
}
