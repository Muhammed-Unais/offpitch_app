import 'package:flutter/material.dart';
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
    final size = MediaQuery.of(context).size;

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
              SizedBox(height: size.height * 0.03),
              Row(
                children: const [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: SignupTopimage(),
                  ),
                  Spacer()
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Create an account",
                          style: Theme.of(context).textTheme.headlineLarge),
                       SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        children: const [
                          Spacer(),
                          Expanded(
                            flex: 8,
                            child: SignupForm(),
                          ),
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
