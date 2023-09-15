class AddplayerValidation {
  static String? nameValidation(String? value) {
    String? values;

    if (value != null) {
      values = value.trim();
    }
    if (values == null || values.isEmpty) {
      return "Name can not be Empty";
    }

    if (values.length < 3) {
      return "Enter Full Name";
    }

    return null;
  }

  static String? dobValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Date can to be Empty";
    }
    return null;
  }
}
