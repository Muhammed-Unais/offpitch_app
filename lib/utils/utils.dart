import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  // Textfield auto focus change
  static fieldFocusChange(
      {required BuildContext context,
      required FocusNode current,
      required FocusNode nextFocus}) {
    current.unfocus();
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
      {required String message, String title = "", context}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(
        seconds: 3,
      ),
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeInOut,
      icon: const Icon(Icons.error),
      positionOffset: 20,
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);
  }

  static showSnackbar(String message, context) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
