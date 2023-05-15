import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class Utils {
  // Textfield auto focus change
  static fieldFocusChange(
      {required BuildContext context,
      required bool isOutfocusNode,
      required FocusNode current,
      required FocusNode nextFocus}) {
    isOutfocusNode
        ? current.unfocus()
        : FocusScope.of(context).requestFocus(nextFocus);
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

  static showCustomFlushbar(BuildContext context, String message,{bool isError =true}) {
    Flushbar(
      message: message,
      messageColor:isError? Colors.red :Colors.green,
      messageSize: 16,
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 2.0,
          blurRadius: 10.0,
          offset: const Offset(0, 3),
        ),
      ],
      mainButton: TextButton(
        onPressed: () {
          // Add your button action here
        },
        child: IconButton(
          color:isError? Colors.red :Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      icon:  Icon(
        Icons.info_outline,
        size: 28.0,
        color: isError ? Colors.red :Colors.green,
      ),
      shouldIconPulse: false,
      showProgressIndicator: true,
      progressIndicatorBackgroundColor:isError ? Colors.red :Colors.green,
      progressIndicatorValueColor:
           AlwaysStoppedAnimation<Color>(isError? Colors.red: Colors.green),
      titleText:  Text(
        isError ?'Error':'Message',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color:isError ? Colors.red :AppColors.primary,
        ),
      ),
    ).show(context);
  }

  static showSnackbar(String message, context) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showDialogue(context, {required Widget child}) {
    showModalBottomSheet(
      elevation: 0,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
