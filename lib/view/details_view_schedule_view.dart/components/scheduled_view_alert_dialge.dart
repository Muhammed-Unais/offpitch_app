import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/textformfied_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/services.dart/add_result_validation/add_result_validation.dart';
import 'package:offpitch_app/view/details_view_schedule_view.dart/view_model/schedule_tournament_view_model.dart';
import 'package:provider/provider.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog(
      {super.key,
      this.team1cover,
      this.team2cover,
      this.team1Name,
      this.team2Name,
      this.matchNo,
      this.roundNo,
      this.tournamentId});

  final String? team1cover;
  final String? team2cover;
  final String? team1Name;
  final String? team2Name;
  final String? tournamentId;
  final int? matchNo;
  final int? roundNo;

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  final TextEditingController scoreController1 = TextEditingController();
  final TextEditingController scoreController2 = TextEditingController();
  final formkey = GlobalKey<FormState>();

  FocusNode scoreController1Node = FocusNode();
  FocusNode scoreController2Node = FocusNode();

  @override
  void dispose() {
    scoreController1.dispose();
    scoreController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ), //this right here
      child: Container(
        padding: const EdgeInsets.all(AppPadding.large),
        height: 240,
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.white,
                        backgroundImage: NetworkImage(
                          widget.team1cover == null ||
                                  widget.team1cover!.isEmpty
                              ? "https://www.gstatic.com/onebox/sports/logos/crest_48dp.png"
                              : widget.team1cover!,
                        ),
                        radius: 24,
                      ),
                      const SizedBox(
                        width: AppMargin.small,
                      ),
                      Text(
                        (widget.team1Name ?? "Team A").toUpperCase(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        (widget.team2Name ?? "Team B").toUpperCase(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        width: AppMargin.small,
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.white,
                        backgroundImage: NetworkImage(
                          widget.team2cover == null ||
                                  widget.team2cover!.isEmpty
                              ? "https://www.gstatic.com/onebox/sports/logos/crest_48dp.png"
                              : widget.team2cover!,
                        ),
                        radius: 24,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormFieldsComponent(
                      type: TextInputType.number,
                      validator: AddResultValidation.goalValidation,
                      hintText: "0",
                      maxLines: 1,
                      controller: scoreController1,
                      currentFocusNode: scoreController1Node,
                      nextFocusNode: scoreController2Node,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: TextFormFieldsComponent(
                      type: TextInputType.number,
                      validator: AddResultValidation.goalValidation,
                      hintText: "0",
                      maxLines: 1,
                      controller: scoreController2,
                      currentFocusNode: scoreController2Node,
                      nextFocusNode: scoreController2Node,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      // add result api calling=============
                      final addResults =
                          Provider.of<ScheduleTournametViewModel>(context,
                              listen: false);
                      await addResults.addResult(
                        widget.tournamentId,
                        matchNo: widget.matchNo,
                        roundNo: widget.roundNo,
                        teamA: int.parse(scoreController1.text),
                        teamB: int.parse(scoreController2.text),
                        context: context,
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(color: Colors.green, width: 1),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
