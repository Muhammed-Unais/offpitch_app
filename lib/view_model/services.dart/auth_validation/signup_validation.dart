import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/utils.dart';

class SignupValidation {
  static passwordValidatiion(value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Password can not be empty";
    } else if (value.length < 8) {
      return "Password Too short";
    } else if (!regExp.hasMatch(value)) {
      return "Enter a strong Password";
    }
    return null;
  }

  static emailValidation(value) {
    final email = value;
    final isValid = EmailValidator.validate(email);
    if (value == null || value.isEmpty) {
      return "Enter Your Email";
    } else if (!isValid) {
      return "Enter Valid Email";
    }
    return null;
  }

  static nameValidaton(value) {
    const pattern = r'^(?=.*?[a-z])';
    RegExp regExp = RegExp(pattern);

    log(regExp.hasMatch(value).toString());
    if (!regExp.hasMatch(value)) {
      return "Enter valid name";
    }
    String? values;
    if (value != null) {
      values = value.toString().trim();
    }

    if (values == null || values.isEmpty) {
      return "Name can not be empty";
    }
    return null;
  }

  static signupErrorDisplay(BuildContext context, error) {
    if (error.toString().contains("No Internet connection")) {
      Utils.showCustomFlushbar(
        context,
        "No Internet connection",
      );
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
      Utils.showCustomFlushbar(
        context,
        error.toString(),
      );
    }
  }
}
