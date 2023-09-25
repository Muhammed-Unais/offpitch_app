import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/features/tournament_details_view/components/registration_components/registration_plyers_widget.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/registration_view_model.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class RegistrationBottomSheet {
  static Future showModelBottomsheet(context,
      {required SingleTournamentModel model,
      required RegistorationViewModel registorationViewModel}) async {
    final data = model.data;
    return showModalBottomSheet(
      useSafeArea: false,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        final size = MediaQuery.of(context).size;

        return ChangeNotifierProvider.value(
          value: registorationViewModel,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'REGISTER FOR TOURNAMENT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Text(
                  data?.title ?? "No Title",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Last Date: ${data?.registration?.lastDate ?? "0/0/0000"}",
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Minimum Players: ${data?.minNoPlayers}",
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹Fee : ${data?.registration?.fee?.amount ?? "0"}",
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Maximuum Players: ${data?.maxNoPlayers}",
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Instruction",
                  style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 12,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: SizedBox(
                    height: 180,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ReadMoreText(
                            textAlign: TextAlign.justify,
                            data?.instruction ?? "No Instruction",
                            style: const TextStyle(
                              fontFamily: "SFUIDisplay",
                              fontSize: 12,
                              color: AppColors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            trimMode: TrimMode.Line,
                            trimLines: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(color: AppColors.grey),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Selected Players:',
                      style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Consumer<RegistorationViewModel>(
                      builder: (context, regeistrationViewModel, _) {
                        return Text(
                          regeistrationViewModel.playersIds.length.toString(),
                          style: const TextStyle(
                            fontFamily: "Lato",
                            fontSize: 12,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const RegistrationPlayersWidget(),
                const SizedBox(height: AppMargin.small),
                Row(
                  children: [
                    Consumer<RegistorationViewModel>(
                      builder: (context, regeistrationViewModel, _) {
                        return Checkbox(
                          fillColor: const MaterialStatePropertyAll(
                            Colors.black,
                          ),
                          activeColor: AppColors.white,
                          checkColor: AppColors.primary,
                          value: regeistrationViewModel.isPermission,
                          onChanged: (bool? value) {
                            regeistrationViewModel.setPermission(value!);
                          },
                        );
                      },
                    ),
                    const Text(
                      'I have read and agree to the all the terms\n and conditions mentioned above',
                      style: TextStyle(
                        fontFamily: "SFUIDisplay",
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppMargin.small),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: size.width * 0.4,
                    child: Consumer<RegistorationViewModel>(
                      builder: (context, regeistrationViewModel, _) {
                        return ElevatedButton(
                          onPressed: regeistrationViewModel.isPermission
                              ? () async {
                                  var plyLength =
                                      regeistrationViewModel.playersIds.length;
                                  var minPlayer = data!.minNoPlayers!;
                                  var maxPlayer = data.maxNoPlayers!;

                                  if (plyLength >= minPlayer &&
                                      plyLength <= maxPlayer) {
                                    context
                                        .read<RegistorationViewModel>()
                                        .postRegisterTournament(
                                            data.id, context);
                                  } else {
                                    Utils.showCustomFlushbar(
                                        context, "Minimum Players required");
                                  }
                                }
                              : null,
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 12,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
