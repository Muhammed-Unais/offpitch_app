import 'dart:async';
import 'package:flutter/material.dart';

class TournamentProvider extends ChangeNotifier {
  Duration _remainingTime = Duration.zero;

  void calculateRemainingTime(DateTime tournamentStartingDate) {
    _remainingTime = tournamentStartingDate.difference(DateTime.now());

    if (_remainingTime.isNegative) {
      _remainingTime = Duration.zero;
      return;
    }

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime = tournamentStartingDate.difference(DateTime.now());

      if (_remainingTime.isNegative) {
        _remainingTime = Duration.zero;
        timer.cancel();
      }

      notifyListeners();
    });
  }

  Duration get remainingTime => _remainingTime;
}
