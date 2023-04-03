import 'dart:convert';
import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/utils.dart';

class LoginValidation {
  static emailValidator(value) {
    final email = value;
    bool isValid = EmailValidator.validate(email!);
    if (value == null || value.isEmpty) {
      return "Enter Your Email";
    } else if (!isValid) {
      return "Enter Valid Email";
    }
    return null;
  }

   static String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return "Password can not be empty";
    } else if (value.length < 8) {
      return "Password Too short";
    }
    return null;
  }

  static loginErrorDisplay(BuildContext context,error){
     // socket exception
        if (error.toString().contains("No Internet connection")) {
          Utils.showFlushbarErrorMessage(
              message: "No Internet connection", context: context);
        }

        // default somthing went wrong
        else if (error
            .toString()
            .contains("error occured while communicating with server")) {
          Utils.showFlushbarErrorMessage(
              message: "Something went wrong", context: context);
        }

        // exception message from server
        else {
          String invalidError = error.toString();
          RegExp regExp = RegExp(r'({.*})');
          RegExpMatch? match = regExp.firstMatch(invalidError);
          String? jsonString = match!.group(0);
          final Map<String, dynamic> errorJson = jsonDecode(jsonString!);
          log(errorJson.toString());
          Utils.showFlushbarErrorMessage(
              message: errorJson['message'], context: context);
        }
  }

  
}
