import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/auth_form_fields.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/login_view/components/doyou_have_acc.dart';
import 'package:offpitch_app/view/login_view/components/forgot_password.dart';
import 'package:offpitch_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:offpitch_app/view_model/services.dart/auth_validation/login_validation.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailTextEditController =
      TextEditingController();

  final TextEditingController _passwordTextEditController =
      TextEditingController();

  final FocusNode _emailFoucsNode = FocusNode();

  final FocusNode _passwordFoucsNode = FocusNode();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier(true);

  final formkey = GlobalKey<FormState>();

  final emailkey = GlobalKey<FormFieldState>();

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
    return Form(
      key: formkey,
      child: Column(
        children: [
          AuthFormField(
            textInputType: TextInputType.emailAddress,
            currentFocusNode: _emailFoucsNode,
            controller: _emailTextEditController,
            nextFocusNode: _passwordFoucsNode,
            hintText: "Email",
            labalText: "Email",
            formkey: emailkey,
            prefix: const Icon(Icons.email),
            validator: (value) => LoginValidation.emailValidator(value),
          ),
          const SizedBox(
            height: AppMargin.large,
          ),
          // password field================
          ValueListenableBuilder(
            valueListenable: _obsecurePassword,
            builder: (context, obsecureValue, child) {
              return AuthFormField(
                  isoutFocusnode: true,
                  textInputType: TextInputType.visiblePassword,
                  currentFocusNode: _passwordFoucsNode,
                  controller: _passwordTextEditController,
                  nextFocusNode: _passwordFoucsNode,
                  hintText: "Password",
                  labalText: "Password",
                  obsecureText: obsecureValue,
                  obsecureValue: "*",
                  prefix: const Icon(Icons.lock_open_outlined),
                  suffix: InkWell(
                    onTap: () {
                      _obsecurePassword.value = !_obsecurePassword.value;
                    },
                    child: obsecureValue
                        ? const Icon(
                            Icons.visibility_off,
                          )
                        : const Icon(
                            Icons.visibility,
                          ),
                  ),
                  validator: LoginValidation.passwordValidator);
            },
          ),
          const SizedBox(
            height: AppMargin.extraLarge,
          ),

          // Forgot Password ================
          ForgotPassword(
            emailkey: emailkey,
            authViewModel: authViewModel,
            emailcontroller: _emailTextEditController,
          ),

          const SizedBox(
            height:AppMargin.extraLarge,
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
            height: AppMargin.extraLarge,
          ),
          const DoyouhaveAcc(),
        ],
      ),
    );
  }
}
