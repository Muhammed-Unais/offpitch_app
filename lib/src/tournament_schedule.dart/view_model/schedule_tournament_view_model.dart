import 'package:flutter/material.dart';
import 'package:offpitch_app/src/tournament_schedule.dart/model/add_result_model.dart';
import 'package:offpitch_app/src/tournament_schedule.dart/repository/add_result_repository.dart';
import 'package:offpitch_app/src/tournament_schedule.dart/repository/schedule_tournament_repository.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/src/tournament_details/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class ScheduleTournametViewModel with ChangeNotifier {
  final _myRepo = SheduleTournametRespository();

  bool isLoading = false;

  void setIsloading(bool isLoad) {
    isLoading = isLoad;
    notifyListeners();
  }

  Future<void> getGetScheduleTournamet(id, context) async {
    setIsloading(true);
    _myRepo.getGetTournamentSchedule(id).then((value) {
      setIsloading(false);
      Provider.of<DetailsTouramentViewModel>(context, listen: false)
          .getSingleTournament(
        id,
      );
      Utils.showCustomFlushbar(context, value['message'], isError: false);
    }).onError((error, stackTrace) {
      Utils.showCustomFlushbar(
        context,
        error.toString(),
      );
      setIsloading(false);
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
            .getSingleTournament(
          id,
        );
        Navigator.pop(context);
        Map<String, dynamic> values = value;
        Utils.showCustomFlushbar(context, values["message"], isError: false);
      },
    ).onError(
      (error, stackTrace) {
        Utils.showCustomFlushbar(context!, error.toString());
      },
    );
  }
}
