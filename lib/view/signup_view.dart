import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailTextEditController =
      TextEditingController();

  final TextEditingController _passwordTextEditController =
      TextEditingController();

  final TextEditingController _userNameTextEditController =
      TextEditingController();

  final FocusNode _emailFoucsNode = FocusNode();

  final FocusNode _passwordFoucsNode = FocusNode();

  final FocusNode _nameFoucusNode = FocusNode();

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
              // Name field
              TextFormField(
                focusNode: _nameFoucusNode,
                keyboardType: TextInputType.emailAddress,
                controller: _userNameTextEditController,
                decoration: const InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  labelText: "Name",
                ),
                onFieldSubmitted: (value) => Utils.fieldFocusChange(
                  context: context,
                  current: _nameFoucusNode,
                  nextFocus: _emailFoucsNode,
                ),
                // validation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name can not be empty";
                  }
                  return null;
                },
              ),
              // Email Field
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
                  final email = _emailTextEditController.text;
                  final isValid = EmailValidator.validate(email);
                  if (value == null || value.isEmpty) {
                    return "Enter Your Email";
                  } else if (!isValid) {
                    return "Enter Valid Email";
                  }
                  return null;
                },
              ),
              // password field
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
                    // validation
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
              // submitt button
              SubmitButton(
                isLoading: authViewModel.isloading,
                actionFunction: () {
                  if (formkey.currentState!.validate()) {
                    final email = _emailTextEditController.text;
                    final password = _passwordTextEditController.text;
                    final name = _userNameTextEditController.text;
                    Map data = {
                      'name': name,
                      'email': email,
                      'password': password
                    };
                    authViewModel.signUpApi(data, context);
                  }
                },
                buttonChildtext: "Submit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
