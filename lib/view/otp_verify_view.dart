import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class OtpVerifyView extends StatelessWidget {
  const OtpVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpeditController = TextEditingController();
    final formkey = GlobalKey<FormState>();
    final authviewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: otpeditController,
              validator: (value) {
                final otp = otpeditController.text;
                if (otp.length < 6 || otp.isEmpty) {
                  return "Enter full Otp";
                }
                return null;
              },
              decoration: const InputDecoration(),
            ),
            const SizedBox(
              height: AppPadding.medium,
            ),
            SubmitButton(
              buttonChildtext: "verify",
              actionFunction: () {
                final otp = otpeditController.text;
                if (formkey.currentState!.validate()) {
                  authviewModel.otpVerifyApi(otp, context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
