import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/utils.dart';

class OtpValidation {
  static otpValidation(value) {
    if (value == null || value.isEmpty || value.length > 1) {
      return "";
    }
    return null;
  }

  static otpErrorDisplay(BuildContext context, error) {
    if (error.toString().contains("No Internet connection")) {
      Utils.showCustomFlushbar(
           context,"No Internet connection");
    }

    // default somthing went wrong
    else if (error
        .toString()
        .contains("error occured while communicating with server")) {
      Utils.showCustomFlushbar(
        context,
        "Something went wrong",
      );
    }

    // exception message from server
    else {
      String invalidError = error.toString();
      RegExp regExp = RegExp(r'({.*})');
      RegExpMatch? match = regExp.firstMatch(invalidError);
      String? jsonString = match?.group(0);
      final Map<String, dynamic> errorJson = jsonDecode(jsonString ?? "");
      log(errorJson.toString());
      Utils.showCustomFlushbar(
        context,
        errorJson['message'],
      );
    }
  }
}
