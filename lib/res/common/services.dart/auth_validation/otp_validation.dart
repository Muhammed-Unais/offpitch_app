

class OtpValidation {
  static String? otpValidation(String? value) {
    if (value == null || value.isEmpty || value.length > 1) {
      return "";
    }
    return null;
  }

}
