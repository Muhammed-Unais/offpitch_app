import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/login_view/widgets/login_form.dart';
import 'package:offpitch_app/view/login_view/widgets/login_view_topimage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: AppMargin.extraLarge*1.5,),
                const LoginViewTopimage(),
                const SizedBox(
                  height: AppMargin.extraLarge,
                ),
                Text("Hi Welcome back",style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(
                  height: AppMargin.extraLarge,
                ),
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
