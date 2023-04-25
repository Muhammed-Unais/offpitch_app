
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

  static loginErrorDisplay(BuildContext context, error) {
    log("${error}ffffff");
    log("9");

    // socket exception
    if (error.toString().contains("No Internet connection")) {
      log("1");
      Utils.showFlushbarErrorMessage(
          message: "No Internet connection", context: context, isError: true);
    }

    // default somthing went wrong
    else if (error
        .toString()
        .contains("error occured while communicating with server")) {
      log("2");
      Utils.showFlushbarErrorMessage(
          message: "Something went wrong", context: context, isError: true);
    }

    // exception message from server
    else {
      Utils.showFlushbarErrorMessage(
          message: error.toString(), context: context, isError: true);
      log(error.toString());
    }
  }
}
