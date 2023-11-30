import 'package:flutter/material.dart';
import 'package:offpitch_app/src/login/components/login_form.dart';
import 'package:offpitch_app/src/login/components/login_view_topimage.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Row(
                  children: [Spacer(), LoginViewTopimage(), Spacer()],
                ),
                SizedBox(height: size.height * 0.03),
                const Text(
                  "Hi WELCOME BACK",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 8,
                      child: LoginForm(),
                    ),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
