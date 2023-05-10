import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/view/signup_view/components/signup_top_image.dart';
import 'package:offpitch_app/view/signup_view/components/sigup_form.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: AppMargin.extraLarge * 1.5,
              ),
              // Signup Top image ===============
              Row(
                children: const [
                  Spacer(),
                  Expanded(flex: 8,
                    child: SignupTopimage()),
                  Spacer()
                ],
              ),
              // create an accoount===============
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Create an account",
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(
                        height: AppMargin.extraLarge,
                      ),
                      // sign form field==================
                      Row(
                        children: const [
                          Spacer(),
                          Expanded(flex: 8, child: SignupForm()),
                          Spacer(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
