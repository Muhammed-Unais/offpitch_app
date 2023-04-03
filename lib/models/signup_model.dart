class SignupModel {
  bool? success;
  Data? data;
  String? message;

  SignupModel({this.success, this.data, this.message});

  SignupModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? confirmToken;

  Data({this.confirmToken});

  Data.fromJson(Map<String, dynamic> json) {
    confirmToken = json['confirmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['confirmToken'] = confirmToken;
    return data;
  }
}
