import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/view/details_view_schedule_view.dart/model/add_result_model.dart';
import 'package:offpitch_app/view/details_view_schedule_view.dart/repository/add_result_repository.dart';
import 'package:offpitch_app/view/details_view_schedule_view.dart/repository/schedule_tournament_repository.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class ScheduleTournametViewModel with ChangeNotifier {
  final _myRepo = SheduleTournametRespository();

  bool isLoading = false;

  setIsloading(bool isLoad) {
    isLoading = isLoad;
    notifyListeners();
  }

  getGetScheduleTournamet(id, context) async {
    setIsloading(true);
    _myRepo.getGetTournamentSchedule(id).then((value) {
      setIsloading(false);
      log(value.toString());
      Provider.of<DetailsTouramentViewModel>(context, listen: false)
          .getSingleTournament(id,);
      Utils.showCustomFlushbar(context, value['message'], isError: false);
    }).onError((error, stackTrace) {
      Utils.showCustomFlushbar(
        context,
        error.toString(),
      );
      setIsloading(false);
      log(error.toString());
    });
  }

  String? setFirstLetterofClubTeamA(String? name) {
    String? value1;
    if (name != null) {
      String? teamAName = name;
      List<String> splitedName = teamAName.split(" ");
      value1 = splitedName.map((word) => word[0]).join('');
    }
    return value1;
  }

  String? setFirstLetterofClubTeamB(String? name) {
    String? value2;

    if (name != null) {
      String? teamBName = name;
      List<String> splitedName2 = teamBName.split(" ");
      value2 = splitedName2.map((word) => word[0]).join('');
    }

    return value2;
  }

  // scheduled League Type type match add Result=====
  final _myRepo1 = AddResultRepository();

  Future addResult(
    id, {
    int? matchNo,
    int? roundNo,
    int? teamA,
    int? teamB,
    BuildContext? context,
  }) async {
    final data = AddResultModel(
        matchNo: matchNo, roundNo: roundNo, teamA: teamA, teamB: teamB);
    await _myRepo1.getPostAddResult(id, data).then(
      (value) {
        Provider.of<DetailsTouramentViewModel>(context!, listen: false)
            .getSingleTournament(id,);
        Navigator.pop(context);
        Map<String, dynamic> values = value;
        Utils.showCustomFlushbar(context, values["message"],isError: false);
      },
    ).onError(
      (error, stackTrace) {
        Utils.showCustomFlushbar(context!, error.toString());
        log(error.toString());
      },
    );
  }
}
