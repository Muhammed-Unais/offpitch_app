import 'package:flutter/material.dart';
import 'package:offpitch_app/src/tournament_details_view/components/registration_components/registration_schedule.dart';
import 'package:offpitch_app/src/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/src/tournament_details_view/components/registration_components/registration_bottom_sheet.dart';
import 'package:offpitch_app/src/tournament_details_view/components/registration_components/registeration_closed.dart';
import 'package:offpitch_app/src/tournament_details_view/components/registration_components/already_registerd.dart';
import 'package:offpitch_app/src/tournament_details_view/components/registration_components/registration_remaining_timer.dart';
import 'package:offpitch_app/src/tournament_details_view/view_model/registration_view_model.dart';
import 'package:offpitch_app/src/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:provider/provider.dart';
import '../../../my_club_view/view_model/my_club_over_view_model.dart';

class RegistrationStatusWidget extends StatefulWidget {
  const RegistrationStatusWidget({
    super.key,
    required this.data,
  });

  final SingleTournamentModel data;

  @override
  State<RegistrationStatusWidget> createState() => _RegistrationStatusWidgetState();
}

class _RegistrationStatusWidgetState extends State<RegistrationStatusWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var myClubProvider = context.read<MyClubViewModel>();
      if (myClubProvider.getPlayerapiResponse.data == null) {
        myClubProvider.getAllPlayers();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<DetailsTouramentViewModel>(
      builder: (context, value, child) {
        final tournamenStatus = widget.data.data?.registration?.status;
        if (value.userSheduleChecking(widget.data, context) &&
            tournamenStatus!.contains('closed')) {
          return RegistrationScheduleBotton(
            id: widget.data.data?.id,
          );
        }
        if (value.remainingTime!.isNegative ||
            tournamenStatus!.contains('closed')) {
          return const RegistrationClosed();
        }
        if (value.registeredOrNotChecking(widget.data, context)) {
          return const AlreadyRegisterd();
        }
        value.calculateRemainingTime(
          widget.data.data?.registration?.lastDate ?? "",
        );
        return Column(
          children: [
            RegistrationRemainingTimer(
              height: size.height * 0.13,
              width: size.width,
              days: '${value.remainingTime!.inDays}',
              hours: (value.remainingTime!.inHours % 24).toString(),
              minuts: (value.remainingTime!.inMinutes % 60).toString(),
              seconds: (value.remainingTime!.inSeconds % 60).toString(),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height * 0.2,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Register Your Team",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
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
                              "Last date \n ${widget.data.data?.registration?.lastDate}",
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontFamily: "Lato",
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(Icons.money_rounded),
                                Text(
                                  "Fee",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 12,
                                    fontFamily: "Lato",
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '₹${widget.data.data?.registration?.fee?.amount}'
                                  .toString(),
                              style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    child: SubmitButton(
                      buttonChildtext: "Register",
                      actionFunction: () async {
                        final value = context.read<RegistorationViewModel>();
                        value.playersIds.clear();

                        value.isPermission = false;
                        var myClubProvider = context.read<MyClubViewModel>();

                        var players =
                            myClubProvider.getPlayerapiResponse.data;

                        if (myClubProvider.getPlayerapiResponse.data !=
                            null) {
                          myClubProvider.setValueChecBoxIndex(players!);
                        }
                        
                        RegistrationBottomSheet.showModelBottomsheet(
                          model: widget.data,
                          context,
                          registorationViewModel: value,
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
