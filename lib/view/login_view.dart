import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditController =
      TextEditingController();

  final TextEditingController _passwordTextEditController =
      TextEditingController();

  final FocusNode _emailFoucsNode = FocusNode();

  final FocusNode _passwordFoucsNode = FocusNode();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier(true);

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextEditController.dispose();
    _passwordTextEditController.dispose();
    _emailFoucsNode.dispose();
    _passwordFoucsNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                focusNode: _emailFoucsNode,
                keyboardType: TextInputType.emailAddress,
                controller: _emailTextEditController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  labelText: "Email",
                ),
                onFieldSubmitted: (value) => Utils.fieldFocusChange(
                  context: context,
                  current: _emailFoucsNode,
                  nextFocus: _passwordFoucsNode,
                ),
                // validation
                validator: (value) {
                  final email =value;
                  bool isValid = EmailValidator.validate(email!);
                  if (value == null || value.isEmpty) {
                    return "Enter Your Email";
                  } else if (!isValid) {
                    return "Enter Valid Email";
                  }
                  return null;
                },
              ),
              ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, obsecureValue, child) {
                  return TextFormField(
                    focusNode: _passwordFoucsNode,
                    obscureText: obsecureValue,
                    obscuringCharacter: "*",
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordTextEditController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                      suffix: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () =>
                            _obsecurePassword.value = !_obsecurePassword.value,
                        icon: Icon(
                          obsecureValue
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password can not be empty";
                      } else if (value.length < 8) {
                        return "Password Too short";
                      }
                      return null;
                    },
                  );
                },
              ),
              SubmitButton(
                isLoading: authViewModel.isloading,
                actionFunction: () {
                  if (formkey.currentState!.validate()) {
                    final email = _emailTextEditController.text;
                    final password = _passwordTextEditController.text;
                    Map data = {'email': email, 'password': password};
                    authViewModel.loginApi(data, context);
                  }
                },
                buttonChildtext: "Submit",
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RoutesName.signup),
                child: const Text("signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
