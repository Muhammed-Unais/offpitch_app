import 'dart:convert';

AddPlayersModel addPlayersModelFromJson(String str) =>
    AddPlayersModel.fromJson(json.decode(str));

String addPlayersModelToJson(AddPlayersModel data) =>
    json.encode(data.toJson());

class AddPlayersModel {
  String? name;
  String? dateOfBirth;
  String? profile;
  String? doc;

  AddPlayersModel({
    this.name,
    this.dateOfBirth,
    this.profile,
    this.doc,
  });

  factory AddPlayersModel.fromJson(Map<String, dynamic> json) =>
      AddPlayersModel(
        name: json["name"],
        dateOfBirth: json["date_of_birth"],
        profile: json["profile"],
        doc: json["doc"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date_of_birth": dateOfBirth,
        "profile": profile,
        "doc": doc,
      };
}
