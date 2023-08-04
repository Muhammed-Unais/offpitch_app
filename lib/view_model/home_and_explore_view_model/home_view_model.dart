
import 'package:flutter/foundation.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/repository/home_repository.dart';

class HomeAndExpViewModel extends ChangeNotifier {
  final _myrepo = HomeRepository();

  int? _count;

  int? get count => _count;

  Future<AllTournamentsModel>? userFuture;

  setValue() async {
    _count = _count != 4
        ? await userFuture?.then((value) {
            return value.data?.allTournaments?.length;
          })
        : 4;
  }

  Future<AllTournamentsModel> getAllTournaments() => _myrepo.allTournamentApi();

  clearAllDataLogout() {
    userFuture = null;
  }
}
