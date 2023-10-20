import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  // Textfield auto focus change
  static void fieldFocusChange(
      {required BuildContext context,
      required bool isOutfocusNode,
      required FocusNode current,
      required FocusNode nextFocus}) {
    isOutfocusNode
        ? current.unfocus()
        : FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.primary,
      textColor: AppColors.white,
      fontSize: 12.0,
    );
  }

  static void showCustomFlushbar(BuildContext context, String message,
      {bool isError = true}) {
    Flushbar(
      messageText: Text(
        message,
        style: TextStyle(
          fontFamily: "SFUIDisplay",
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isError ? Colors.red : Colors.green,
        ),
      ),
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
          color: isError ? Colors.red : Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      icon: Icon(
        Icons.info_outline,
        size: 24.0,
        color: isError ? Colors.red : Colors.green,
      ),
      shouldIconPulse: false,
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: isError ? Colors.red : Colors.green,
      progressIndicatorValueColor:
          AlwaysStoppedAnimation<Color>(isError ? Colors.red : Colors.green),
      titleText: Text(
        isError ? 'Error' : 'Message',
        style: TextStyle(
          fontSize: 16.0,
          fontFamily: "SFUIDisplay",
          fontWeight: FontWeight.bold,
          color: isError ? Colors.red : AppColors.primary,
        ),
      ),
    ).show(context);
  }

  static void showSnackbar(String message, context) {
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

  static Future<void> sharedPrefrence(
      {required String key, required String value}) async {
    final sp = await SharedPreferences.getInstance();

    sp.setString(key, value);
  }

  static Future<String?> sharedPrefrenceGetValue({required String key}) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key);

  }
  static Future<bool> sharedClearAll() async {
    final sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
  static Future<bool> shareRemove({required String key}) async {
    final sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }
}
