
import 'package:email_validator/email_validator.dart';

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

}
