import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_regis_bottom_.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_registered_already_registerd.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_registered_closed.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_registered_schedule_button.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_timer_remaining.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/registration_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class DetailsViewRegister extends StatelessWidget {
  const DetailsViewRegister({super.key, required this.data});

  final SingleTournamentModel data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<DetailsTouramentViewModel>(
      builder: (context, value, child) {
        final tournamenStatus = data.data?.registration?.status;

        // Tournament Scheduling Checking and button ============
        if (value.userSheduleChecking(data,context) &&
            tournamenStatus!.contains('closed')) {
          return DetailsViewRegisteredScheduleBotton(
            id: data.data?.id,
          );
        }
        //  tournament time closed checking======================
        if (value.remainingTime!.isNegative ||
            tournamenStatus!.contains('closed')) {
          return const DetailsViewRegistedClosed();
        }
        //  User already registered or not checking==============
        if (value.registeredOrNotChecking(data,context)) {
          return const DeilsViewRegisterdAlreadyRegisterd();
        }
        value.calculateRemainingTime(
          data.data?.registration?.lastDate ?? "",
        );
        return Column(
          children: [
            DetailsViewTimerRemain(
              height: size.height * 0.13,
              width: size.width,
              days: '${value.remainingTime!.inDays}',
              hours: (value.remainingTime!.inHours % 24).toString(),
              minuts: (value.remainingTime!.inMinutes % 60).toString(),
              seconds: (value.remainingTime!.inSeconds % 60).toString(),
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
                              "Last date \n ${data.data?.registration?.lastDate}",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.money_rounded),
                                Text(
                                  "Fee",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            Text(
                              '₹${data.data?.registration?.fee?.amount}'
                                  .toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  // Ṛegistration Torunament =======================
                  SizedBox(
                    height: 50,
                    child: SubmitButton(
                      buttonChildtext: "Register",
                      actionFunction: () async {
                        final value = Provider.of<RegistorationViewModel>(
                            context,
                            listen: false);
                        value.playersIds.clear();
                        value.isPermission = false;
                        await DetailsViewRegistrationBottomSheet
                            .showModelBottomsheet(
                          model: data,
                          context,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
