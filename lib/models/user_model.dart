class UserModel {
  bool? success;
  String? message;
  Data? data;

  UserModel({this.success, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? profile;
  String? club;
  String? clubStatus;
  String? role;
  String? accessToken;

  Data(
      {this.name,
      this.email,
      this.profile,
      this.club,
      this.clubStatus,
      this.role,
      this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    profile = json['profile'];
    club = json['club'];
    clubStatus = json['clubStatus'];
    role = json['role'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['profile'] = profile;
    data['club'] = club;
    data['clubStatus'] = clubStatus;
    data['role'] = role;
    data['accessToken'] = accessToken;
    return data;
  }
}
