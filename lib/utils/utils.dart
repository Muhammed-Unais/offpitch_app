import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:offpitch_app/res/app_theme.dart';

class Utils {
  // Textfield auto focus change
  static fieldFocusChange(
      {required BuildContext context,
      required bool isOutfocusNode,
      required FocusNode current,
      required FocusNode nextFocus}) {    
    isOutfocusNode ? 
    current.unfocus():
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.TOP,
      fontSize: 16,
    );
  }

  static showFlushbarErrorMessage(
      {required String message, String title = " ", context,required bool isError}) {
    Flushbar(
      message: message,
      messageColor: AppColors.grey,
      messageSize: 18,
      titleColor: AppColors.grey,
      titleSize: 18,
      flushbarPosition: FlushbarPosition.TOP,
      title: title,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.red,
      ),
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeInOut,
      
      progressIndicatorBackgroundColor: Colors.red,
      progressIndicatorValueColor:
          const AlwaysStoppedAnimation<Color>(Colors.red),
      mainButton: IconButton(
        onPressed: () {
          // Flushbar.hide(context);
        },
        icon: const Text(
          'OK',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    ).show(context);
  }

  static showSnackbar(String message, context) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
