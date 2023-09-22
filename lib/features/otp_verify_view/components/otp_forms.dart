import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/features/otp_verify_view/components/small_otp_form.dart';
import 'package:offpitch_app/features/login_view/view_model/auth_view_model.dart';
import 'package:offpitch_app/res/common/services.dart/auth_validation/otp_validation.dart';
import 'package:provider/provider.dart';

class OtpForms extends StatefulWidget {
  const OtpForms({super.key, required this.currentSeconds});

  final int currentSeconds;

  @override
  State<OtpForms> createState() => _OtpFormsState();
}

class _OtpFormsState extends State<OtpForms> {
  final formkey = GlobalKey<FormState>();

  late FocusNode focusNode1 = FocusNode();
  late FocusNode focusNode2 = FocusNode();
  late FocusNode focusNode3 = FocusNode();
  late FocusNode focusNode4 = FocusNode();
  late FocusNode focusNode5 = FocusNode();
  late FocusNode focusNode6 = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();
    super.dispose();
  }

  void nextField(String? value, FocusNode focusNode) {
    if (value?.length == 1) {
      focusNode.requestFocus();
      return;
    }
    if (value == null || value.isEmpty) {
      focusNode.previousFocus();
      return;
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
                focusNode: focusNode1,
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
                  otpForm2 = value;
                  nextField(value.toString(), focusNode3);
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
                  otpForm6 = value;
                  if (value != null && value.isNotEmpty) {
                    focusNode6.unfocus();
                  } else {
                    focusNode6.previousFocus();
                  }
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
          buttonChildtext: "VERIFY",
          actionFunction: widget.currentSeconds >= 90
              ? null
              : () {
                  if (formkey.currentState!.validate()) {
                    String totalOtpValue = otpForm1! +
                        otpForm2! +
                        otpForm3! +
                        otpForm4! +
                        otpForm5! +
                        otpForm6!;
                    authviewModel.otpVerifyApi(totalOtpValue, context);
                  }
                },
        ),
      ],
    );
  }
}
