import 'package:offpitch_app/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.data, this.message, this.status);

  ApiResponse.error() : status = Status.ERROR;

  ApiResponse.conpleted() : status = Status.COMPLETED;

  ApiResponse.loading() : status = Status.LOADING;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}
