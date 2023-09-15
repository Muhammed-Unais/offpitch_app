import 'dart:convert';

UserHostTournametModel userHostTournametModelFromJson(Map<String,dynamic> data) => UserHostTournametModel.fromJson(data);

String userHostTournametModelToJson(UserHostTournametModel data) => json.encode(data.toJson());

class UserHostTournametModel {
    bool? success;
    List<Datum>? data;

    UserHostTournametModel({
        this.success,
        this.data,
    });

    factory UserHostTournametModel.fromJson(Map<String, dynamic> json) => UserHostTournametModel(
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
    String? cover;
    String? location;
    String? shortDescription;
    String? startDate;
    StatusTour? status;
    String? title;
    int? teamsCount;

    Datum({
        this.id,
        this.cover,
        this.location,
        this.shortDescription,
        this.startDate,
        this.status,
        this.title,
        this.teamsCount,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        cover: json["cover"],
        location: json["location"],
        shortDescription: json["short_description"],
        startDate: json["start_date"],
        status: statusValues.map[json["status"]]!,
        title: json["title"],
        teamsCount: json["teams_count"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "cover": cover,
        "location": location,
        "short_description": shortDescription,
        "start_date": startDate,
        "status": statusValues.reverse[status],
        "title": title,
        "teams_count": teamsCount,
    };
}

enum StatusTour { ACTIVE, DRAFT }

final statusValues = EnumValues({
    "active": StatusTour.ACTIVE,
    "draft": StatusTour.DRAFT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}