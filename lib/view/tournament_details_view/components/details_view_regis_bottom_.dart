import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_btmsht_players_add.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/registration_view_model.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class DetailsViewRegistrationBottomSheet {
  static Future showModelBottomsheet(context,
      {required SingleTournamentModel model}) async {
    await Provider.of<MyClubViewModel>(context, listen: false).getAllPlayers();
    final data = model.data;
    return showModalBottomSheet(
      useSafeArea: false,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        final regeistrationViewModel = context.watch<RegistorationViewModel>();
        return Container(
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.large, horizontal: AppPadding.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Register for Tournament',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppMargin.medium),
              Text(data?.title ?? "No Title",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last Date:${data?.registration?.lastDate ?? "0/0/0000"}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Minimum Players:${data?.minNoPlayers}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹Fee : ${data?.registration?.fee?.amount ?? "0"}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Maximuum Players:${data?.maxNoPlayers}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              const SizedBox(height: AppMargin.medium),
              Text(
                "Instruction",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppMargin.small),
              SizedBox(
                height: 200,
                child: ReadMoreText(
                  data?.instruction ?? "No Instruction",
                  style: Theme.of(context).textTheme.bodyLarge,
                  trimMode: TrimMode.Line,
                  trimLines: 10,
                ),
              ),
              const SizedBox(height: AppMargin.large),
              const Divider(color: AppColors.grey),
              const SizedBox(height: AppMargin.large),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selected Players:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 10.0),
                  Text(regeistrationViewModel.playersIds.length.toString(),
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),

              // Selecting Players here====================================
              const SizedBox(height: 10.0),
              const DetailsViewBtmShtPlayersAdd(),
              const SizedBox(height: AppMargin.small),
              Row(
                children: [
                  Checkbox(
                    value: regeistrationViewModel.isPermission,
                    onChanged: (bool? value) {
                      regeistrationViewModel.setPermission(value!);
                    },
                  ),
                  Text(
                      'I have read and agree to the all the terms\n and conditions mentioned above',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              const SizedBox(height: AppMargin.small),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: regeistrationViewModel.isPermission
                        ? () async {
                          
                            // Registration====================================
                            log(regeistrationViewModel.playersIds.length
                                .toString());
                            log(data!.maxNoPlayers.toString());
                            if (regeistrationViewModel.playersIds.length >=
                                    data.minNoPlayers! &&
                                regeistrationViewModel.playersIds.length <=
                                    data.maxNoPlayers!) {
                              await Provider.of<RegistorationViewModel>(
                                      context,
                                      listen: false)
                                  .postRegisterTournament(data.id, context);
                            } else {
                              Utils.showCustomFlushbar(
                                  context, "Minimum Players required");
                            }
                          }
                        : null,
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
