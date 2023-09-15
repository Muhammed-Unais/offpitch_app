import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/login_view/components/login_form.dart';
import 'package:offpitch_app/features/login_view/components/login_view_topimage.dart';

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
                // Top Image=================
                Row(
                  children: const [Spacer(), LoginViewTopimage(), Spacer()],
                ),
                SizedBox(height: size.height * 0.03),
                // Welcome Text===============
                Text("Hi Welcome back",
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(
                  height: AppMargin.extraLarge,
                ),
                // Form fields=================
                Row(
                  children: const [
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
