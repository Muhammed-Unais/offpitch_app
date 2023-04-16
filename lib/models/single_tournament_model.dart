// To parse this JSON data, do
//
//     final singleTournamentModel = singleTournamentModelFromJson(jsonString);

import 'dart:convert';

SingleTournamentModel singleTournamentModelFromJson(String str) => SingleTournamentModel.fromJson(json.decode(str));

String singleTournamentModelToJson(SingleTournamentModel data) => json.encode(data.toJson());

class SingleTournamentModel {
    SingleTournamentModel({
        required this.success,
        required this.message,
        required this.data,
    });

    bool success;
    String message;
    Data data;

    factory SingleTournamentModel.fromJson(Map<String, dynamic> json) => SingleTournamentModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.id,
        required this.host,
        required this.v,
        required this.cover,
        required this.createdAt,
        required this.description,
        required this.groups,
        required this.instruction,
        required this.location,
        required this.maxNoPlayers,
        required this.minNoPlayers,
        required this.noTeams,
        required this.registration,
        required this.shortDescription,
        required this.startDate,
        required this.status,
        required this.teams,
        required this.ticket,
        required this.title,
        required this.tournamentType,
        required this.updatedAt,
    });

    String id;
    Host host;
    int v;
    String cover;
    DateTime createdAt;
    String description;
    List<dynamic> groups;
    String instruction;
    String location;
    int maxNoPlayers;
    int minNoPlayers;
    int noTeams;
    Registration registration;
    String shortDescription;
    String startDate;
    String status;
    List<dynamic> teams;
    Ticket ticket;
    String title;
    String tournamentType;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        host: Host.fromJson(json["host"]),
        v: json["__v"],
        cover: json["cover"],
        createdAt: DateTime.parse(json["createdAt"]),
        description: json["description"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        instruction: json["instruction"],
        location: json["location"],
        maxNoPlayers: json["max_no_players"],
        minNoPlayers: json["min_no_players"],
        noTeams: json["no_teams"],
        registration: Registration.fromJson(json["registration"]),
        shortDescription: json["short_description"],
        startDate: json["start_date"],
        status: json["status"],
        teams: List<dynamic>.from(json["teams"].map((x) => x)),
        ticket: Ticket.fromJson(json["ticket"]),
        title: json["title"],
        tournamentType: json["tournament_type"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "host": host.toJson(),
        "__v": v,
        "cover": cover,
        "createdAt": createdAt.toIso8601String(),
        "description": description,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "instruction": instruction,
        "location": location,
        "max_no_players": maxNoPlayers,
        "min_no_players": minNoPlayers,
        "no_teams": noTeams,
        "registration": registration.toJson(),
        "short_description": shortDescription,
        "start_date": startDate,
        "status": status,
        "teams": List<dynamic>.from(teams.map((x) => x)),
        "ticket": ticket.toJson(),
        "title": title,
        "tournament_type": tournamentType,
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Host {
    Host({
        required this.id,
        required this.email,
        required this.name,
        required this.phone,
        required this.profile,
    });

    String id;
    String email;
    String name;
    int phone;
    String profile;

    factory Host.fromJson(Map<String, dynamic> json) => Host(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "phone": phone,
        "profile": profile,
    };
}

class Registration {
    Registration({
        required this.fee,
        required this.lastDate,
        required this.status,
    });

    Fee fee;
    String lastDate;
    String status;

    factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        fee: Fee.fromJson(json["fee"]),
        lastDate: json["last_date"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "fee": fee.toJson(),
        "last_date": lastDate,
        "status": status,
    };
}

class Fee {
    Fee({
        required this.feeIs,
        required this.amount,
    });

    bool feeIs;
    int amount;

    factory Fee.fromJson(Map<String, dynamic> json) => Fee(
        feeIs: json["is"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "is": feeIs,
        "amount": amount,
    };
}

class Ticket {
    Ticket();

    factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    );

    Map<String, dynamic> toJson() => {
    };
}
