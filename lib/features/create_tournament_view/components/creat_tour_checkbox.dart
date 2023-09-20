import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/textformfied_components.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/create_tournament_view/view_model/create_tournament_view_model.dart';
import 'package:provider/provider.dart';

class CreateTournamentCheckbox extends StatelessWidget {
  const CreateTournamentCheckbox({super.key, this.amoutFeesValidator});

  final String? Function(String?)? amoutFeesValidator;

  @override
  Widget build(BuildContext context) {
    final tourCreateViewModel = Provider.of<CreateTournamentViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      margin:
          const EdgeInsets.only(left: AppMargin.large, right: AppMargin.large),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                activeColor: AppColors.primary,
                checkColor: AppColors.white,
                value: tourCreateViewModel.ischeck,
                onChanged: (bool? value) {
                  tourCreateViewModel.setAmountCheck(value);
                },
              ),
              const Text(
                "Registration fee",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          tourCreateViewModel.ischeck!
              ? Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: TextFormFieldsComponent(
                        validator: amoutFeesValidator,
                        isOutfoucsNode: true,
                        type: TextInputType.number,
                        hintText: "Amount",
                        currentFocusNode: tourCreateViewModel.amountFoucusNode,
                        nextFocusNode: tourCreateViewModel.amountFoucusNode,
                        controller: tourCreateViewModel.amountController,
                        maxLines: null,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "₹",
                      style: TextStyle(
                        fontFamily: "Pilat",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    )
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
