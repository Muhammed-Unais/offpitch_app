import 'package:offpitch_app/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.data, this.message, this.status);

  ApiResponse.error(this.message) : status = Status.ERROR;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.loading() : status = Status.LOADING;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }

}
