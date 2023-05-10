import 'dart:convert';

RegistrationTour registrationFromJson(String str) => RegistrationTour.fromJson(json.decode(str));

String registrationTourToJson(RegistrationTour data) => json.encode(data.toJson());

class RegistrationTour {
    List<String>? players;

    RegistrationTour({
        this.players,
    });

    factory RegistrationTour.fromJson(Map<String, dynamic> json) => RegistrationTour(
        players: json["players"] == null ? [] : List<String>.from(json["players"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "players": players == null ? [] : List<dynamic>.from(players!.map((x) => x)),
    };
}