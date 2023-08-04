import 'dart:async';
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/view/otp_verify_view/components/otp_forms.dart';
import 'package:offpitch_app/view/otp_verify_view/components/otp_timer.dart';
import 'package:offpitch_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class OtpVerifyView extends StatefulWidget {
  const OtpVerifyView({super.key});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
  final int timerMaxSeconds = 90;
  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  void _stratTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _stratTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
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
                currentSeconds >= timerMaxSeconds
                    ? const Text(
                        "Your OTP has expired",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : OtpTimer(timerText: timerText),
                SizedBox(
                  height: size.height / 6,
                ),
                OtpForms(currentSeconds: currentSeconds),
                SizedBox(
                  height: size.height / 12,
                ),
                currentSeconds >= timerMaxSeconds
                    ? GestureDetector(
                        onTap: () {
                          authViewModel.resendOtp(context);
                        },
                        child: authViewModel.signUpLoading
                            ? const CircularProgressIndicator(
                              strokeWidth: 2,value: 5,
                              color: AppColors.primary,
                            )
                            : const Text(
                                "Resend OTP Code",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      )
                    : Text(
                        "Resend OTP Code",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 18,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
