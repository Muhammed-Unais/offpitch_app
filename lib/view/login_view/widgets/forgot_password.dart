import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/view_model/auth_view_model.dart';

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
           Text(
            "Forgot Password? ",
            style:Theme.of(context).textTheme.bodyLarge
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
                :  Text(
                    "reset now",
                    style: Theme.of(context).textTheme.labelLarge
                  ),
          ),
        ],
      ),
    );
  }
}
