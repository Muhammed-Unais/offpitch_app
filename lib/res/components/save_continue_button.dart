import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/res/styles/constats.dart';

class SaveContinueButton extends StatelessWidget {
  const SaveContinueButton(
      {super.key,
      required this.width,
      required this.btnFunction,
      required this.text,
      required this.isloading});

  final double width;
  final void Function() btnFunction;
  final String text;
  final bool isloading;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: width,
        height: 40,
        margin: const EdgeInsets.only(
            left: AppMargin.large,
            right: AppMargin.large,
            bottom: AppMargin.medium,
            top: AppMargin.medium),
        child: SubmitButton(
          isLoading: isloading,
          buttonChildtext: text,
          actionFunction: btnFunction,
        ),
      ),
    );
  }
}
