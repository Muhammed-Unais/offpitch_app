
import 'dart:convert';

UserProfileModel userProfileModelFromJson(Map<String,dynamic> data) => UserProfileModel.fromJson(data);

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    bool? success;
    Data? data;

    UserProfileModel({
        this.success,
        this.data,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    String? id;
    String? name;
    String? email;
    String? status;
    int? wallet;
    String? comment;
    String? profile;
    int? v;
    Club? club;

    Data({
        this.id,
        this.name,
        this.email,
        this.status,
        this.wallet,
        this.comment,
        this.profile,
        this.v,
        this.club,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        status: json["status"],
        wallet: json["wallet"],
        comment: json["comment"],
        profile: json["profile"],
        v: json["__v"],
        club: json["club"] == null ? null : Club.fromJson(json["club"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "status": status,
        "wallet": wallet,
        "comment": comment,
        "profile": profile,
        "__v": v,
        "club": club?.toJson(),
    };
}

class Club {
    String? id;
    int? followers;
    String? name;
    int? players;
    String? profile;
    String? status;

    Club({
        this.id,
        this.followers,
        this.name,
        this.players,
        this.profile,
        this.status,
    });

    factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json["_id"],
        followers: json["followers"],
        name: json["name"],
        players: json["players"],
        profile: json["profile"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "followers": followers,
        "name": name,
        "players": players,
        "profile": profile,
        "status": status,
    };
}
