
import 'dart:convert';

SingleTournamentModel singleTournamentModelFromJson(Map<String,dynamic> data) => SingleTournamentModel.fromJson(data);

String singleTournamentModelToJson(SingleTournamentModel data) => json.encode(data.toJson());


class SingleTournamentModel {
    SingleTournamentModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    Data? data;

    factory SingleTournamentModel.fromJson(Map<String, dynamic> json) => SingleTournamentModel(
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
    Data({
        this.id,
        this.host,
        this.v,
        this.cover,
        this.createdAt,
        this.description,
        this.groups,
        this.instruction,
        this.location,
        this.maxNoPlayers,
        this.minNoPlayers,
        this.noTeams,
        this.registration,
        this.shortDescription,
        this.startDate,
        this.status,
        this.teams,
        this.ticket,
        this.title,
        this.tournamentType,
        this.updatedAt,
        this.matches,
    });

    String? id;
    Host? host;
    int? v;
    String? cover;
    DateTime? createdAt;
    String? description;
    List<Group>? groups;
    String? instruction;
    String? location;
    int? maxNoPlayers;
    int? minNoPlayers;
    int? noTeams;
    Registration? registration;
    String? shortDescription;
    String? startDate;
    String? status;
    List<dynamic>? teams;
    Ticket? ticket;
    String? title;
    String? tournamentType;
    DateTime? updatedAt;
    Matches? matches;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        host: json["host"] == null ? null : Host.fromJson(json["host"]),
        v: json["__v"],
        cover: json["cover"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        description: json["description"],
        groups: json["groups"] == null ? [] : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        instruction: json["instruction"],
        location: json["location"],
        maxNoPlayers: json["max_no_players"],
        minNoPlayers: json["min_no_players"],
        noTeams: json["no_teams"],
        registration: json["registration"] == null ? null : Registration.fromJson(json["registration"]),
        shortDescription: json["short_description"],
        startDate: json["start_date"],
        status: json["status"],
        teams: json["teams"] == null ? [] : List<dynamic>.from(json["teams"]!.map((x) => x)),
        ticket: json["ticket"] == null ? null : Ticket.fromJson(json["ticket"]),
        title: json["title"],
        tournamentType: json["tournament_type"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        matches: json["matches"] == null ? null : Matches.fromJson(json["matches"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "host": host?.toJson(),
        "__v": v,
        "cover": cover,
        "createdAt": createdAt?.toIso8601String(),
        "description": description,
        "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "instruction": instruction,
        "location": location,
        "max_no_players": maxNoPlayers,
        "min_no_players": minNoPlayers,
        "no_teams": noTeams,
        "registration": registration?.toJson(),
        "short_description": shortDescription,
        "start_date": startDate,
        "status": status,
        "teams": teams == null ? [] : List<dynamic>.from(teams!.map((x) => x)),
        "ticket": ticket?.toJson(),
        "title": title,
        "tournament_type": tournamentType,
        "updatedAt": updatedAt?.toIso8601String(),
        "matches": matches?.toJson(),
    };
}

class Group {
    Group({
        this.name,
        this.noTeams,
        this.teams,
        this.id,
    });

    String? name;
    int? noTeams;
    List<dynamic>? teams;
    String? id;

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        name: json["name"],
        noTeams: json["no_teams"],
        teams: json["teams"] == null ? [] : List<dynamic>.from(json["teams"]!.map((x) => x)),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "no_teams": noTeams,
        "teams": teams == null ? [] : List<dynamic>.from(teams!.map((x) => x)),
        "_id": id,
    };
}

class Host {
    Host({
        this.id,
        this.email,
        this.name,
        this.phone,
        this.profile,
    });

    String? id;
    String? email;
    String? name;
    int? phone;
    String? profile;

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

class Matches {
    Matches({
        this.id,
        this.host,
        this.cMatch,
        this.rounds,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String? id;
    String? host;
    List<int>? cMatch;
    List<dynamic>? rounds;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Matches.fromJson(Map<String, dynamic> json) => Matches(
        id: json["_id"],
        host: json["host"],
        cMatch: json["c_match"] == null ? [] : List<int>.from(json["c_match"]!.map((x) => x)),
        rounds: json["rounds"] == null ? [] : List<dynamic>.from(json["rounds"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "host": host,
        "c_match": cMatch == null ? [] : List<dynamic>.from(cMatch!.map((x) => x)),
        "rounds": rounds == null ? [] : List<dynamic>.from(rounds!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Registration {
    Registration({
        this.fee,
        this.lastDate,
        this.status,
    });

    Fee? fee;
    String? lastDate;
    String? status;

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
    Fee({
        this.amount,
        this.feeIs,
    });

    int? amount;
    bool? feeIs;

    factory Fee.fromJson(Map<String, dynamic> json) => Fee(
        amount: json["amount"],
        feeIs: json["is"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "is": feeIs,
    };
}

class Ticket {
    Ticket({
        this.amount,
        this.ticketIs,
        this.total,
    });

    int? amount;
    bool? ticketIs;
    int? total;

    factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        amount: json["amount"],
        ticketIs: json["is"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "is": ticketIs,
        "total": total,
    };
}
