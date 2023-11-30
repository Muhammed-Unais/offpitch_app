import 'dart:async';
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/otp_verify/components/otp_forms.dart';
import 'package:offpitch_app/src/otp_verify/components/otp_timer.dart';
import 'package:offpitch_app/src/login/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class OtpVerifyView extends StatefulWidget {
  const OtpVerifyView({super.key});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
  final int timerMaxSeconds = 90;
  int currentSeconds = 0;
  late Timer timer;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  void _stratTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timers) {
      setState(() {
        timer = timers;
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
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authViewModel = context.watch<AuthViewModel>();
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
                const Text(
                  "OTP VERIFICATION",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter the code recived in Your registered email',
                  style: TextStyle(
                    fontFamily: "SFUIDisplay",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                currentSeconds >= timerMaxSeconds
                    ? const Text(
                        "Your OTP has expired",
                        style: TextStyle(
                          fontFamily: "SFUIDisplay",
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
                          authViewModel.resendOtp(context).then((_) {
                            _stratTimer();
                          });
                        },
                        child: authViewModel.signUpLoading
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primary,
                              )
                            : const Text(
                                "Resend OTP Code",
                                style: TextStyle(
                                  fontFamily: "SFUIDisplay",
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      )
                    : Text(
                        "Resend OTP Code",
                        style: TextStyle(
                          fontFamily: "SFUIDisplay",
                          color: Colors.grey.shade400,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
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
