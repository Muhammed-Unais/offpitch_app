import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/view/otp_verify_view/components/small_otp_form.dart';
import 'package:offpitch_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:offpitch_app/view_model/services.dart/auth_validation/otp_validation.dart';
import 'package:provider/provider.dart';

class OtpForms extends StatefulWidget {
  const OtpForms({super.key});

  @override
  State<OtpForms> createState() => _OtpFormsState();
}

class _OtpFormsState extends State<OtpForms> {
  final TextEditingController otpeditController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;
  late FocusNode focusNode6;

  @override
  void initState() {
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode6 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();
    super.dispose();
  }

  nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  String? otpForm1;
  String? otpForm2;
  String? otpForm3;
  String? otpForm4;
  String? otpForm5;
  String? otpForm6;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authviewModel = Provider.of<AuthViewModel>(context);
    return Column(
      children: [
        Form(
          key: formkey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallOtpForm(
                validator: (value) => OtpValidation.otpValidation(value),
                onChanged: (value) {
                  nextField(value.toString(), focusNode2);
                  otpForm1 = value;
                },
              ),
              SmallOtpForm(
                validator: (value) => OtpValidation.otpValidation(value),
                focusNode: focusNode2,
                onChanged: (value) {
                  nextField(value.toString(), focusNode3);
                  otpForm2 = value;
                },
              ),
              SmallOtpForm(
                validator: (value) => OtpValidation.otpValidation(value),
                focusNode: focusNode3,
                onChanged: (value) {
                  nextField(value.toString(), focusNode4);
                  otpForm3 = value;
                },
              ),
              SmallOtpForm(
                validator: (value) => OtpValidation.otpValidation(value),
                focusNode: focusNode4,
                onChanged: (value) {
                  nextField(value.toString(), focusNode5);
                  otpForm4 = value;
                },
              ),
              SmallOtpForm(
                validator: (value) => OtpValidation.otpValidation(value),
                focusNode: focusNode5,
                onChanged: (value) {
                  nextField(value.toString(), focusNode6);
                  otpForm5 = value;
                },
              ),
              SmallOtpForm(
                validator: (value) => OtpValidation.otpValidation(value),
                focusNode: focusNode6,
                onChanged: (value) {
                  focusNode6.unfocus();
                  otpForm6 = value;
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height / 10,
        ),
        SubmitButton(
          isLoading: authviewModel.otpVerifyIsLoading,
          buttonChildtext: "Verify",
          actionFunction: () {
            if (formkey.currentState!.validate()) {
              String totalOtpValue = otpForm1! +
                  otpForm2! +
                  otpForm3! +
                  otpForm4! +
                  otpForm5! +
                  otpForm6!;
              log(totalOtpValue);
              authviewModel.otpVerifyApi(totalOtpValue, context);
            }
          },
        ),
      ],
    );
  }
}
