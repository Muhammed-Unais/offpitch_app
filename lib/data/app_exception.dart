class AppExceptions implements Exception {

  final dynamic _message;
  final dynamic _prefix;

  AppExceptions([this._message, this._prefix]);
  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppExceptions {  
  FetchDataException([String? messages])
      : super(messages, 'Error during Communication');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? messages])
      : super(messages, 'Invalid request');
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String? messages])
      : super(messages, 'Unauthorised request');
}

class InavalidInputException extends AppExceptions {
  InavalidInputException([String? messages])
      : super(messages, 'Invalid Input');
}

