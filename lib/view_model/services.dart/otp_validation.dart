class OtpValidation {
  static otpValidation(value) {
    if (value == null ||
        value.isEmpty ||
        value.length > 1 ) {
      return "";
    }
    return null;
  }
}
