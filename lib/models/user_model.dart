import 'dart:convert';

UserModel userModelFromJson(Map<String,dynamic> data) => UserModel.fromJson(data);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    bool? success;
    String? message;
    Data? data;

    UserModel({
        this.success,
        this.message,
        this.data,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? name;
    String? email;
    String? profile;
    String? club;
    String? clubStatus;
    String? role;
    String? accessToken;

    Data({
        this.name,
        this.email,
        this.profile,
        this.club,
        this.clubStatus,
        this.role,
        this.accessToken,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        profile: json["profile"],
        club: json["club"],
        clubStatus: json["clubStatus"],
        role: json["role"],
        accessToken: json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profile": profile,
        "club": club,
        "clubStatus": clubStatus,
        "role": role,
        "accessToken": accessToken,
    };
}
