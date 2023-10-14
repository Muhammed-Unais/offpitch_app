// To parse this JSON data, do
//
//     final allTournamentsModel = allTournamentsModelFromJson(jsonString);

import 'dart:convert';

AllTournamentsModel allTournamentsModelFromJson(Map<String,dynamic> str) => AllTournamentsModel.fromJson(str);

String allTournamentsModelToJson(AllTournamentsModel data) => json.encode(data.toJson());

class AllTournamentsModel {
    AllTournamentsModel({
         this.success,
         this.data,
    });

    bool? success;
    Data? data;

    factory AllTournamentsModel.fromJson(Map<String, dynamic> json) => AllTournamentsModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
         this.allTournaments,
         this.total,
         this.page,
         this.limit,
    });

    List<AllTournament>? allTournaments;
    int? total;
    int? page;
    int? limit;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        allTournaments: List<AllTournament>.from(json["allTournaments"].map((x) => AllTournament.fromJson(x))),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "allTournaments": List<dynamic>.from(allTournaments!.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
    };
}

class AllTournament {
    AllTournament({
         this.id,
         this.host,
         this.cover,
         this.location,
         this.shortDescription,
         this.startDate,
         this.status,
         this.title,
         this.teamsCount,
         this.teams,
         this.isSaved,
    });

    String? id;
    Host? host;
    String? cover;
    String? location;
    String? shortDescription;
    String? startDate;
    String? status;
    String? title;
    int? teamsCount;
    List<dynamic>? teams;
    bool? isSaved;

    factory AllTournament.fromJson(Map<String, dynamic> json) => AllTournament(
        id: json["_id"],
        host: Host.fromJson(json["host"]),
        cover: json["cover"],
        location: json["location"],
        shortDescription: json["short_description"],
        startDate: json["start_date"],
        status: json["status"],
        title: json["title"],
        teamsCount: json["teams_count"],
        teams: List<dynamic>.from(json["teams"].map((x) => x)),
        isSaved: json["isSaved"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "host": host?.toJson(),
        "cover": cover,
        "location": location,
        "short_description": shortDescription,
        "start_date": startDate,
        "status": status,
        "title": title,
        "teams_count": teamsCount,
        "teams": List<dynamic>.from(teams!.map((x) => x)),
        "isSaved": isSaved,
    };
}

class Host {
    Host({
         this.id,
         this.email,
         this.name,
         this.phone,
    });

    String? id;
    String? email;
    String? name;
    int? phone;

    factory Host.fromJson(Map<String, dynamic> json) => Host(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "phone": phone,
    };
}
