import 'dart:developer';

import 'package:intl/intl.dart';

class   TournamentCreationValidation {
  static String? dateValidator(String? value) {
    final todayDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(todayDate);

    if (value == formattedDate) {
      return "Enter Valid Date";
    }
    if (value == null || value.isEmpty) {
      return "Enter Valid Date";
    }
    return null;
  }

  static String? locationValidator(String? value) {
    String? values;
    if (value != null) {
      const pattern = r'^(?=.*?[a-z])';
      RegExp regExp = RegExp(pattern);

      log("1");
      log(value);
      log(regExp.hasMatch(value).toString());
      if (!regExp.hasMatch(value)) {
        return "Enter valid Location";
      }
      values = value.toString().trim();
    }

    if (values == null || values.isEmpty) {
      return "Location can not be empty";
    }
    return null;
  }

  static String? titleValidator(String? value) {
    String? values;
    if (value != null) {
      const pattern = r'^(?=.*?[a-z])';
      RegExp regExp = RegExp(pattern);

      log("1");
      log(value);
      log(regExp.hasMatch(value).toString());
      if (!regExp.hasMatch(value)) {
        return "Enter valid Title";
      }
      values = value.toString().trim();
      if (value.length < 10) {
        return "Atleast 10 characters";
      }
    }

    if (values == null || values.isEmpty) {
      return "Title can not be empty";
    }
    return null;
  }

  static String? descriptionValidator(String? value) {
    String? values;
    if (value != null) {
      values = value.toString().trim();
      if (value.length < 200) {
        return "Atleast 200 characters";
      }
      if (value.length > 400) {
        return "Too long, maximum of 400 characters";
      }
    }

    if (values == null || values.isEmpty) {
      return "Description can not be empty";
    }
    return null;
  }

  static String? aboutValidator(String? value) {
    String? values;
    if (value != null) {
      values = value.toString().trim();
      if (value.length < 500) {
        return "Atleast 500 characters";
      }
    }

    if (values == null || values.isEmpty) {
      return "About section can not be empty";
    }
    return null;
  }


  static String? instructionValidator(String? value) {
    String? values;
    if (value != null) {
      values = value.toString().trim();
      if (value.length < 500) {
        return "Instruction should be 500 characters long";
      }
    }

    if (values == null || values.isEmpty) {
      return "Instruction can not be empty";
    }
    return null;
  }

  static String? maxNoOfRegValidator(String? value) {
    String? values;
    if (value != null&&value.isNotEmpty) {
      values = value.toString().trim();
      if (int.parse(value.trim())< 4) {
        return "Atleast 4 teams needed";
      }
      if (int.parse(value.trim())>64) {
        return "Can only register upto 64 teams maximum";
      } 
    }

    if (values == null || values.isEmpty) {
      return "No of registration can not be empty";
    }
    return null;
  }
  
   static String? lastdateRegValidator(String? value) {
    
    if (value == null || value.isEmpty) {
      return "Enter Valid Date";
    }
    return null;
  }
  
  static String? minNoOfPlayers(String? value) {
    String? values; 
    if (value != null&&value.isNotEmpty) {
      values = value.toString().trim();
      if (int.parse(value.trim())< 3) {
        return "3-a-side the minimum match";
      }
      if (int.parse(value.trim())>11) {
        return "Only upto 11-a-side match";
      }
    }

    if (values == null || values.isEmpty) {
      return "No of players can not be empty";
    }
    return null;
  }

  static String? maxNoOfPlayers(String? value) {
    String? values; 
    if (value != null&&value.isNotEmpty) {
      values = value.toString().trim();
      if (int.parse(value.trim())< 3) {
        return "3-a-side the minimum match";
      }
      if (int.parse(value.trim())>22) {
        return "Only max upto 18 players";
      }
    }

    if (values == null || values.isEmpty) {
      return "No of players can not be empty";
    }
    return null;
  }

  static String? amountValidator(String? value) {
    String? values; 
    if (value != null&&value.isNotEmpty) {
      values = value.toString().trim();
    
      if (value.length >5) {
        return "Enter Valid Fees";
      }
    }

    if (values == null || values.isEmpty) {
      return "Fees can not be empty";
    }
    return null;
  }

  
}
