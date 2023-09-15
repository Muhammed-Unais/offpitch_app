
import 'package:email_validator/email_validator.dart';

class ClubCreationValidation {
  static String? emailValidation(String? value) {
    final email = value;
    final isValid = EmailValidator.validate(email ??"");
    if (value == null || value.isEmpty) {
      return "Enter Your Email";
    } else if (!isValid) {
      return "Enter Valid Email";
    }
    return null;
  }

  static String? nameValidaton(String? value) {
    const pattern = r'^(?=.*?[a-z])';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value ??"")) {
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

  static String? phoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Your Email";
    }
    const pattern = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(pattern)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? discrptionValidation(String? value) {
    if (value == null || value.isEmpty || value.length < 220) {
      return "Too Short";
    }
    return null;
  }
}
