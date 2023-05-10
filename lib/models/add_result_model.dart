
import 'dart:convert';

AddResultModel addResultModelFromJson(String str) => AddResultModel.fromJson(json.decode(str));

String addResultModelToJson(AddResultModel data) => json.encode(data.toJson());

class AddResultModel {
    int? teamA;
    int? teamB;
    int? matchNo;
    int? roundNo;

    AddResultModel({
        this.teamA,
        this.teamB,
        this.matchNo,
        this.roundNo,
    });

    factory AddResultModel.fromJson(Map<String, dynamic> json) => AddResultModel(
        teamA: json["teamA"],
        teamB: json["teamB"],
        matchNo: json["match_no"],
        roundNo: json["round_no"],
    );

    Map<String, dynamic> toJson() => {
        "teamA": teamA,
        "teamB": teamB,
        "match_no": matchNo,
        "round_no": roundNo,
    };
}
