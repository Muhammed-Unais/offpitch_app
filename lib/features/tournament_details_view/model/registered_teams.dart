import 'dart:convert';

RegisterdTeamsModel registerdTeamsModelFromJson(Map<String,dynamic> data) => RegisterdTeamsModel.fromJson(data);

String registerdTeamsModelToJson(RegisterdTeamsModel data) => json.encode(data.toJson());

class RegisterdTeamsModel {
    bool? success;
    Data? data;

    RegisterdTeamsModel({
        this.success,
        this.data,
    });

    factory RegisterdTeamsModel.fromJson(Map<String, dynamic> json) => RegisterdTeamsModel(
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
    String? profile;
    String? description;
    List<Player>? players;

    Data({
        this.id,
        this.name,
        this.profile,
        this.description,
        this.players,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        profile: json["profile"],
        description: json["description"],
        players: json["players"] == null ? [] : List<Player>.from(json["players"]!.map((x) => Player.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profile": profile,
        "description": description,
        "players": players == null ? [] : List<dynamic>.from(players!.map((x) => x.toJson())),
    };
}

class Player {
    String? name;
    DateTime? dateOfBirth;
    String? profile;
    String? doc;
    String? status;
    String? id;

    Player({
        this.name,
        this.dateOfBirth,
        this.profile,
        this.doc,
        this.status,
        this.id,
    });

    factory Player.fromJson(Map<String, dynamic> json) => Player(
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

