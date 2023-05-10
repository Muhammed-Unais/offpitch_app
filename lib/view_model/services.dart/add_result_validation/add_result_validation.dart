class AddResultValidation{

   static String? goalValidation(String? value) {
     String? values;

    if (value != null) {
      values = value.trim();
    }
    if (values == null || values.isEmpty) {
      return "Goal can not be Empty";
    }

    if (values.length > 2) {
      return "";
    }

    return null;
  }
}