import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_regis_bottom_.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_timer_remaining.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/registration_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/schedule_tournament_view_model.dart';
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

        // Tournament Scheduling Checking=========================
        if (value.userSheduleChecking(data) &&
            tournamenStatus!.contains('closed')) {
          return Column(
            children: [
              const Text(
                "Schedule tournament",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                  fontSize: 24,
                ),
              ),
              ChangeNotifierProvider(
                create: (context) => ScheduleTournametViewModel(),
                child: Consumer<ScheduleTournametViewModel>(
                  builder: (context, value, _) {
                    return Container(
                      margin: const EdgeInsets.only(
                        left: AppMargin.large,
                        right: AppMargin.large,
                        top: AppMargin.medium,
                      ),
                      width: size.width,
                      child: OutlinedButton(
                        onPressed: () {
                          value.getGetScheduleTournamet(
                              data.data?.id, context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: const BorderSide(color: Colors.red, width: 0.5),
                        ),
                        child: value.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.red,
                                strokeWidth: 2,
                              )
                            : const Text(
                                'Schedule',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        //  tournament time closed checking=======================
        if (value.remainingTime!.isNegative ||
            tournamenStatus!.contains('closed')) {
          return Column(
            children: [
              SvgPicture.asset(
                theme: const SvgTheme(currentColor: Colors.grey),
                "assets/images/access-denied.svg",
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: AppMargin.small,
              ),
              const Text(
                textAlign: TextAlign.center,
                "Registration Closed",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          );
        }
        //  User already registered or not checking====================
        if (value.registeredOrNotChecking(data)) {
          return Column(
            children: [
              SvgPicture.asset(
                "assets/images/registered.svg",
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: AppMargin.extraSmall,
              ),
              const Text(
                textAlign: TextAlign.center,
                "Already Registered",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          );
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
                  // Ṛegistration flutter===========================
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
