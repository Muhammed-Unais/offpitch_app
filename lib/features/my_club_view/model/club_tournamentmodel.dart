
import 'dart:convert';

ClubTournamentModel clubTournamentModelFromJson(Map<String,dynamic> data) => ClubTournamentModel.fromJson(data);

String clubTournamentModelToJson(ClubTournamentModel data) => json.encode(data.toJson());

class ClubTournamentModel {
    ClubTournamentModel({
        required this.success,
        this.data,
        required this.message,
    });

    bool success;
    Data? data;
    String message;

    factory ClubTournamentModel.fromJson(Map<String, dynamic> json) => ClubTournamentModel(
        success: json["success"],
        data:json['message'].toString().contains('One club found')? Data.fromJson(json["data"]):null,
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
        "message": message,
    };
}

class Data {
    Data({
        required this.id,
        required this.author,
        required this.v,
        required this.comment,
        required this.createdAt,
        required this.description,
        required this.doc,
        required this.email,
        required this.followers,
        required this.name,
        required this.phone,
        required this.players,
        required this.profile,
        required this.status,
        required this.updatedAt,
    });

    String? id;
    String? author;
    int? v;
    String? comment;
    DateTime? createdAt;
    String? description;
    String? doc;
    String? email;
    int followers;
    String? name;
    int? phone;
    List<dynamic> players;
    String? profile;
    String? status;
    DateTime? updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        author: json["author"],
        v: json["__v"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        description: json["description"],
        doc: json["doc"],
        email: json["email"],
        followers: json["followers"],
        name: json["name"],
        phone: json["phone"],
        players: List<dynamic>.from(json["players"].map((x) => x)),
        profile: json["profile"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "author": author,
        "__v": v,
        "comment": comment,
        "createdAt": createdAt?.toIso8601String(),
        "description": description,
        "doc": doc,
        "email": email,
        "followers": followers,
        "name": name,
        "phone": phone,
        "players": List<dynamic>.from(players.map((x) => x)),
        "profile": profile,
        "status": status,
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
