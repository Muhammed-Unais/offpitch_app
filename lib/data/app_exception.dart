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
      : super(messages, '');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? messages])
      : super(messages, '');
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String? messages])
      : super(messages, '');
}

class InavalidInputException extends AppExceptions {
  InavalidInputException([String? messages])
      : super(messages, '');
}

