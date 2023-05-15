import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/repository/home_repository.dart';

class HomeAndExpViewModel extends ChangeNotifier {
  final _myrepo = HomeRepository();

  Future<AllTournamentsModel>? userFuture;

  setValue() {
    userFuture = getAllTournaments();
  }

  Future<AllTournamentsModel> getAllTournaments() => _myrepo.allTournamentApi();

  clearAllDataLogout() {
    userFuture = null;
    log(userFuture.toString());
  }
}
