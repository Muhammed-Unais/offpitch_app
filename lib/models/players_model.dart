
import 'dart:convert';

PlayersModel playersModelFromJson(Map<String,dynamic> str) => PlayersModel.fromJson(str);

String playersModelToJson(PlayersModel data) => json.encode(data.toJson());

class PlayersModel {
    PlayersModel({
        this.success,
        this.data,
    });

    bool? success;
    List<Datum>? data;

    factory PlayersModel.fromJson(Map<String, dynamic> json) => PlayersModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.name,
        this.dateOfBirth,
        this.profile,
        this.doc,
        this.status,
        this.id,
    });

    String? name;
    DateTime? dateOfBirth;
    String? profile;
    String? doc;
    String? status;
    String? id;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        profile: json["profile"],
        doc: json["doc"],
        status: json["status"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "profile": profile,
        "doc": doc,
        "status": status,
        "_id": id,
    };
}
