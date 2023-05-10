
import 'dart:convert';

UserWatchlistModel userWatchlistModelFromJson(Map<String,dynamic> data) => UserWatchlistModel.fromJson(data);

String userWatchlistModelToJson(UserWatchlistModel data) => json.encode(data.toJson());

class UserWatchlistModel {
    bool? success;
    List<Datum>? data;

    UserWatchlistModel({
        this.success,
        this.data,
    });

    factory UserWatchlistModel.fromJson(Map<String, dynamic> json) => UserWatchlistModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? title;
    String? cover;
    String? startDate;
    String? status;

    Datum({
        this.id,
        this.title,
        this.cover,
        this.startDate,
        this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        title: json["title"],
        cover: json["cover"],
        startDate: json["start_date"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "cover": cover,
        "start_date": startDate,
        "status": status,
    };
}
