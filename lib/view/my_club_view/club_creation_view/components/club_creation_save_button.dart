import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/res/constats.dart';

class ClubCreationSaveButton extends StatelessWidget {
  const ClubCreationSaveButton(
      {super.key, required this.width, required this.btnFunction,this.buttonText='Save'});

  final double width;
  final void Function() btnFunction;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: width,
        height: 40,
        margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.large,
        ),
        child: SubmitButton(
          buttonChildtext: buttonText,
          actionFunction: btnFunction,
        ),
      ),
    );
  }
}
