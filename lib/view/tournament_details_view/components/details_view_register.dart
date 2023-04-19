import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_timer_remaining.dart';
import 'package:offpitch_app/view_model/torunament_details_timer_view_model.dart';
import 'package:provider/provider.dart';

class DetailsViewRegister extends StatelessWidget {
  const DetailsViewRegister({super.key, required this.data});

  final SingleTournamentModel data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => TournamentProvider(),
      child: Consumer<TournamentProvider>(
        builder: (context, value, child) {
          Duration remainingTime = Duration.zero;
          DateTime dateTime = DateTime.now();
          log(dateTime.toString());
          DateTime tournamentStartingDate =
              DateFormat("MM/dd/yyyy").parse(data.data.registration.lastDate);
          log(tournamentStartingDate.toString());
          remainingTime = tournamentStartingDate.difference(DateTime.now());
          log(remainingTime.toString());
          if (remainingTime.isNegative ||
              data.data.registration.status.contains('closed')) {
            return const Text("Registration closed");
          }

          value.calculateRemainingTime(tournamentStartingDate);
          return Column(
            children: [
              DetailsViewTimerRemain(
                height: size.height * 0.13,
                width: size.width,
                days: value.remainingTime.inDays.toString(),
                hours: (value.remainingTime.inHours % 24).toString(),
                minuts: (value.remainingTime.inMinutes % 60).toString(),
                seconds: (value.remainingTime.inSeconds % 60).toString(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: AppMargin.large, vertical: AppMargin.large),
                height: size.height * 0.2,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Register Your Team",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              const Icon(Icons.lock_clock),
                              Text(
                                "Last date \n ${data.data.registration.lastDate}",
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                        data.data.registration.fee.feeIs
                            ? SizedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.money_rounded),
                                        Text(
                                          "Fee",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '₹${data.data.registration.fee.amount}'
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: SubmitButton(
                        buttonChildtext: "Register",
                        actionFunction: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
