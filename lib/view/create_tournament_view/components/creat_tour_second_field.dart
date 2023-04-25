import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/textformfied_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/create_tournament_view_model.dart';
import 'package:provider/provider.dart';

class CreateTournamentSecondFields extends StatelessWidget {
  const CreateTournamentSecondFields(
      {super.key,
      this.instructionValidator,
      this.maxNoOfRegValidator,
      this.lastDateRegValidator,
      this.maxNoOfPlayersValidator, this.minOfPlayersValidator});

  final String? Function(String?)? instructionValidator,
      maxNoOfRegValidator,
      lastDateRegValidator,
      minOfPlayersValidator,
      maxNoOfPlayersValidator;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final clubcreatNewViewModel =
        Provider.of<CreateTournamentViewModel>(context);
    return Container(
      height: size.height * 0.6,
      width: size.width,
      margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.large, vertical: AppMargin.large),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: TextFormFieldsComponent(
              type: TextInputType.name,
              nextFocusNode: clubcreatNewViewModel.maxNoOfRegFoucsNode,
              currentFocusNode: clubcreatNewViewModel.instructionFoucsNode,
              validator: instructionValidator,
              controller: clubcreatNewViewModel.instructionController,
              hintText: "Instructions for clubs",
              maxLines: 7,
            ),
          ),
          Expanded(
            child: TextFormFieldsComponent(
              type: TextInputType.number,
              currentFocusNode: clubcreatNewViewModel.maxNoOfRegFoucsNode,
              nextFocusNode: clubcreatNewViewModel.lastDateRegusNode,
              validator: maxNoOfRegValidator,
              controller: clubcreatNewViewModel.noOfRegistrationController,
              hintText: "Max no of registration",
              maxLines: null,
            ),
          ),
          Expanded(
            child: TextFormFieldsComponent(
              onTap: () async {
                clubcreatNewViewModel.datePickerinTextfield(context,isStartDate: false);
              },
              type: TextInputType.none,
              currentFocusNode: clubcreatNewViewModel.lastDateRegusNode,
              nextFocusNode: clubcreatNewViewModel.minOfPlayersFoucusNode,
              validator: lastDateRegValidator,
              controller: clubcreatNewViewModel.lastDateTorurnamentController,
              hintText: "Last date of registration",
              maxLines: null,
            ),
          ),
          Expanded(
            child: TextFormFieldsComponent(
              type: TextInputType.number,
              currentFocusNode: clubcreatNewViewModel.minOfPlayersFoucusNode,
              nextFocusNode: clubcreatNewViewModel.maxOfPlayersFoucusNode,
              validator: minOfPlayersValidator,
              controller: clubcreatNewViewModel.minOfPlayersController,
              hintText: "Min no of players",
              maxLines: null,
            ),
          ),
          Expanded(
            child: TextFormFieldsComponent(
              type: TextInputType.number,
              isOutfoucsNode: true,
              currentFocusNode: clubcreatNewViewModel.maxOfPlayersFoucusNode,
              nextFocusNode: clubcreatNewViewModel.maxOfPlayersFoucusNode,
              validator: maxNoOfPlayersValidator,
              controller: clubcreatNewViewModel.maxOfPlayersController,
              hintText: "Max no of players",
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
