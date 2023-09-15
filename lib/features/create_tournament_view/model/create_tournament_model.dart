import 'dart:convert';

CreateTournament createTournamentFromJson(String str) =>
    CreateTournament.fromJson(json.decode(str));

String createTournamentToJson(CreateTournament data) =>
    json.encode(data.toJson());

class CreateTournament {
  CreateTournament({
    this.cover,
    this.title,
    this.shortDescription,
    this.startDate,
    this.description,
    this.instruction,
    this.noTeams,
    this.location,
    this.registration,
    this.minNoPlayers,
    this.maxNoPlayers,
    this.ticket,
    this.tournamentType,
    this.step
  });

  String? cover;
  String? title;
  String? shortDescription;
  String? startDate;
  String? description;
  String? instruction;
  int? noTeams;
  String? location;
  Registration? registration;
  int? minNoPlayers;
  int? maxNoPlayers;
  Ticket? ticket;
  String? tournamentType;
  int? step;

  factory CreateTournament.fromJson(Map<String, dynamic> json) =>
      CreateTournament(
        title: json["title"],
        shortDescription: json["short_description"],
        startDate: json["start_date"],
        description: json["description"],
        instruction: json["instruction"],
        noTeams: json["no_teams"],
        location: json["location"],
        registration: json["registration"] == null
            ? null
            : Registration.fromJson(json["registration"]),
        minNoPlayers: json["min_no_players"],
        maxNoPlayers: json["max_no_players"],
        ticket: json["ticket"] == null ? null : Ticket.fromJson(json["ticket"]),
        tournamentType: json["tournament_type"],
      );

  Map<String, dynamic> toJson() => {
        "cover": cover,
        "title": title,
        "short_description": shortDescription,
        "start_date": startDate,
        "description": description,
        "instruction": instruction,
        "no_teams": noTeams,
        "location": location,
        "registration": registration?.toJson(),
        "min_no_players": minNoPlayers,
        "max_no_players": maxNoPlayers,
        "ticket": ticket?.toJson(),
        "tournament_type": tournamentType,
        "step":step
      };
}

class Registration {
  Registration({
    this.lastDate,
    this.fee,
  });

  String? lastDate;
  Fee? fee;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        lastDate: json["last_date"],
        fee: json["fee"] == null ? null : Fee.fromJson(json["fee"]),
      );

  Map<String, dynamic> toJson() => {
        "last_date": lastDate,
        "fee": fee?.toJson(),
      };
}

class Fee {
  Fee({
    this.feeIs,
    this.amount,
  });

  bool? feeIs;
  int? amount;

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
  Ticket({
    this.ticketIs,
    this.amount,
    this.total,
  });

  bool? ticketIs;
  int? amount;
  int? total;

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
