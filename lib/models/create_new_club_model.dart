
import 'dart:convert';

CreateClubModel createClubModelFromJson(String str) => CreateClubModel.fromJson(json.decode(str));

String createClubModelToJson(CreateClubModel data) => json.encode(data.toJson());

class CreateClubModel {
    CreateClubModel({
        required this.name,
        required this.email,
        required this.phone,
        required this.description,
        required this.profile,
        required this.doc,
    });

    String name;
    String email;
    String phone;
    String description;
    String profile;
    String doc;

    factory CreateClubModel.fromJson(Map<String, dynamic> json) => CreateClubModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        description: json["description"],
        profile: json["profile"],
        doc: json["doc"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "description": description,
        "profile": profile,
        "doc": doc,
    };
}
