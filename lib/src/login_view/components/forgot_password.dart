import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/login_view/view_model/auth_view_model.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword(
      {super.key,
      required this.emailkey,
      required this.emailcontroller,
      required this.authViewModel});

  final GlobalKey<FormFieldState> emailkey;
  final TextEditingController emailcontroller;
  final AuthViewModel authViewModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Text(
            "Forgot Password? ",
            style: TextStyle(
              fontFamily: "SFUIDisplay",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (emailkey.currentState!.validate()) {
                final email = emailcontroller.text;
                final Map data = {"email": email};
                authViewModel.forgotPassword(context, data);
              }
            },
            child: authViewModel.forgotPasResetLoading
                ? const SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : const Text(
                    "reset now",
                    style: TextStyle(
                      fontFamily: "SFUIDisplay",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
