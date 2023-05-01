import 'dart:convert';

SingleTournamentModel singleTournamentModelFromJson(Map<String,dynamic> data) => SingleTournamentModel.fromJson(data);

String singleTournamentModelToJson(SingleTournamentModel data) => json.encode(data.toJson());

class SingleTournamentModel {
    bool? success;
    String? message;
    Data? data;

    SingleTournamentModel({
        this.success,
        this.message,
        this.data,
    });

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
    String? id;
    Host? host;
    int? v;
    String? cover;
    DateTime? createdAt;
    String? description;
    List<dynamic>? groups;
    String? instruction;
    String? location;
    int? maxNoPlayers;
    int? minNoPlayers;
    int? noTeams;
    Registration? registration;
    String? shortDescription;
    String? startDate;
    String? status;
    List<TeamElement>? teams;
    Ticket? ticket;
    String? title;
    String? tournamentType;
    DateTime? updatedAt;
    Matches? matches;

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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        host: json["host"] == null ? null : Host.fromJson(json["host"]),
        v: json["__v"],
        cover: json["cover"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        description: json["description"],
        groups: json["groups"] == null ? [] : List<dynamic>.from(json["groups"]!.map((x) => x)),
        instruction: json["instruction"],
        location: json["location"],
        maxNoPlayers: json["max_no_players"],
        minNoPlayers: json["min_no_players"],
        noTeams: json["no_teams"],
        registration: json["registration"] == null ? null : Registration.fromJson(json["registration"]),
        shortDescription: json["short_description"],
        startDate: json["start_date"],
        status: json["status"],
        teams: json["teams"] == null ? [] : List<TeamElement>.from(json["teams"]!.map((x) => TeamElement.fromJson(x))),
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
        "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "instruction": instruction,
        "location": location,
        "max_no_players": maxNoPlayers,
        "min_no_players": minNoPlayers,
        "no_teams": noTeams,
        "registration": registration?.toJson(),
        "short_description": shortDescription,
        "start_date": startDate,
        "status": status,
        "teams": teams == null ? [] : List<dynamic>.from(teams!.map((x) => x.toJson())),
        "ticket": ticket?.toJson(),
        "title": title,
        "tournament_type": tournamentType,
        "updatedAt": updatedAt?.toIso8601String(),
        "matches": matches?.toJson(),
    };
}

class Host {
    String? id;
    String? email;
    String? name;
    int? phone;
    String? profile;

    Host({
        this.id,
        this.email,
        this.name,
        this.phone,
        this.profile,
    });

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
    String? id;
    String? host;
    List<int>? cMatch;
    List<Round>? rounds;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Matches({
        this.id,
        this.host,
        this.cMatch,
        this.rounds,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Matches.fromJson(Map<String, dynamic> json) => Matches(
        id: json["_id"],
        host: json["host"],
        cMatch: json["c_match"] == null ? [] : List<int>.from(json["c_match"]!.map((x) => x)),
        rounds: json["rounds"] == null ? [] : List<Round>.from(json["rounds"]!.map((x) => Round.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "host": host,
        "c_match": cMatch == null ? [] : List<dynamic>.from(cMatch!.map((x) => x)),
        "rounds": rounds == null ? [] : List<dynamic>.from(rounds!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Round {
    String? name;
    int? noMatches;
    int? roundNo;
    List<Match>? matches;
    String? id;

    Round({
        this.name,
        this.noMatches,
        this.roundNo,
        this.matches,
        this.id,
    });

    factory Round.fromJson(Map<String, dynamic> json) => Round(
        name: json["name"],
        noMatches: json["no_matches"],
        roundNo: json["round_no"],
        matches: json["matches"] == null ? [] : List<Match>.from(json["matches"]!.map((x) => Match.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "no_matches": noMatches,
        "round_no": roundNo,
        "matches": matches == null ? [] : List<dynamic>.from(matches!.map((x) => x.toJson())),
        "_id": id,
    };
}

class Match {
    int? matchNo;
    Team? teamA;
    Team? teamB;
    String? id;

    Match({
        this.matchNo,
        this.teamA,
        this.teamB,
        this.id,
    });

    factory Match.fromJson(Map<String, dynamic> json) => Match(
        matchNo: json["match_no"],
        teamA: json["teamA"] == null ? null : Team.fromJson(json["teamA"]),
        teamB: json["teamB"] == null ? null : Team.fromJson(json["teamB"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "match_no": matchNo,
        "teamA": teamA?.toJson(),
        "teamB": teamB?.toJson(),
        "_id": id,
    };
}

class Team {
    String? club;
    String? name;
    String? profile;
    int? goals;
    List<dynamic>? scorer;

    Team({
        this.club,
        this.name,
        this.profile,
        this.goals,
        this.scorer,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        club: json["club"],
        name: json["name"],
        profile: json["profile"],
        goals: json["goals"],
        scorer: json["scorer"] == null ? [] : List<dynamic>.from(json["scorer"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "club": club,
        "name": name,
        "profile": profile,
        "goals": goals,
        "scorer": scorer == null ? [] : List<dynamic>.from(scorer!.map((x) => x)),
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

class TeamElement {
    String? club;
    String? name;
    String? profile;
    List<String>? players;
    String? status;
    String? id;

    TeamElement({
        this.club,
        this.name,
        this.profile,
        this.players,
        this.status,
        this.id,
    });

    factory TeamElement.fromJson(Map<String, dynamic> json) => TeamElement(
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

class Ticket {
    bool? ticketIs;
    int? amount;
    int? total;

    Ticket({
        this.ticketIs,
        this.amount,
        this.total,
    });

    factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        ticketIs: json["is"],
        amount: json["amount"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "is": ticketIs,
        "amount": amount,
        "total": total,
    };
}
