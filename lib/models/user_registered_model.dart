import 'dart:convert';

UserRegisterdTournametnModel userRegisterdTournametnModelFromJson(Map<String,dynamic> data) => UserRegisterdTournametnModel.fromJson(data);

String userRegisterdTournametnModelToJson(UserRegisterdTournametnModel data) => json.encode(data.toJson());

class UserRegisterdTournametnModel {
    bool? success;
    List<RegisteredTournaments>? data;

    UserRegisterdTournametnModel({
        this.success,
        this.data,
    });

    factory UserRegisterdTournametnModel.fromJson(Map<String, dynamic> json) => UserRegisterdTournametnModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<RegisteredTournaments>.from(json["data"]!.map((x) => RegisteredTournaments.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class RegisteredTournaments {
    String? id;
    String? cover;
    String? location;
    Registration? registration;
    String? startDate;
    String? status;
    Teams? teams;
    String? title;

    RegisteredTournaments({
        this.id,
        this.cover,
        this.location,
        this.registration,
        this.startDate,
        this.status,
        this.teams,
        this.title,
    });

    factory RegisteredTournaments.fromJson(Map<String, dynamic> json) => RegisteredTournaments(
        id: json["_id"],
        cover: json["cover"],
        location: json["location"],
        registration: json["registration"] == null ? null : Registration.fromJson(json["registration"]),
        startDate: json["start_date"],
        status: json["status"],
        teams: json["teams"] == null ? null : Teams.fromJson(json["teams"]),
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "cover": cover,
        "location": location,
        "registration": registration?.toJson(),
        "start_date": startDate,
        "status": status,
        "teams": teams?.toJson(),
        "title": title,
    };
}

class Registration {
    Fee? fee;
    String? lastDate;
    String? status;

    Registration({
        this.fee,
        this.lastDate,
        this.status,
    });

    factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        fee: json["fee"] == null ? null : Fee.fromJson(json["fee"]),
        lastDate: json["last_date"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "fee": fee?.toJson(),
        "last_date": lastDate,
        "status": status,
    };
}

class Fee {
    bool? feeIs;
    int? amount;

    Fee({
        this.feeIs,
        this.amount,
    });

    factory Fee.fromJson(Map<String, dynamic> json) => Fee(
        feeIs: json["is"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "is": feeIs,
        "amount": amount,
    };
}

class Teams {
    String? club;
    String? name;
    String? profile;
    List<String>? players;
    String? status;
    String? id;

    Teams({
        this.club,
        this.name,
        this.profile,
        this.players,
        this.status,
        this.id,
    });

    factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        club: json["club"],
        name: json["name"],
        profile: json["profile"],
        players: json["players"] == null ? [] : List<String>.from(json["players"]!.map((x) => x)),
        status: json["status"],
        id: json["_id"],
    );  

    Map<String, dynamic> toJson() => {
        "club": club,
        "name": name,
        "profile": profile,
        "players": players == null ? [] : List<dynamic>.from(players!.map((x) => x)),
        "status": status,
        "_id": id,
    };
}