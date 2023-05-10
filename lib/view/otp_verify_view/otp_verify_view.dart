import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/view/otp_verify_view/components/otp_forms.dart';
import 'package:offpitch_app/view/otp_verify_view/components/otp_timer.dart';


class OtpVerifyView extends StatelessWidget {
  const OtpVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          style: IconButton.styleFrom(),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 12,
                ),
                Text(
                  "OTP Verification",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppMargin.medium),
                Text(
                  'Enter the code recived in Your registered email',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppMargin.small),
                const OtpTimer(),
                SizedBox(
                  height: size.height / 6,
                ),
                const OtpForms(),
                SizedBox(
                  height: size.height / 12,
                ),
                Text(
                  "Resend OTP Code",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
