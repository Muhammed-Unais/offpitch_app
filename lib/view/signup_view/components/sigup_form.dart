import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/auth_form_fields.dart';
import 'package:offpitch_app/res/components/submit_button.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/signup_view/components/already_have_acc.dart';
import 'package:offpitch_app/view_model/auth_view_model.dart';
import 'package:offpitch_app/view_model/services.dart/signup_validation.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
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
    _userNameTextEditController.dispose();
    _emailTextEditController.dispose();
    _passwordTextEditController.dispose();
    _nameFoucusNode.dispose();
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
          // Name Field===================
          AuthFormField(
            currentFocusNode: _nameFoucusNode,
            controller: _userNameTextEditController,
            nextFocusNode: _emailFoucsNode,
            hintText: "Name",
            labalText: "Name",
            validator: (value) => SignupValidation.nameValidaton(value),
            textInputType: TextInputType.name,
          ),
          const SizedBox(
            height: AppMargin.large,
          ),
          // Email Field===================
          AuthFormField(
            currentFocusNode: _emailFoucsNode,
            controller: _emailTextEditController,
            nextFocusNode: _passwordFoucsNode,
            hintText: "Email",
            labalText: "Email",
            validator: (value) => SignupValidation.emailValidation(value),
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: AppMargin.large,
          ),
          // Password Field ===============
          ValueListenableBuilder(
            valueListenable: _obsecurePassword,
            builder: (context, obsecureValue, child) {
              return AuthFormField(
                isoutFocusnode: true,
                currentFocusNode: _passwordFoucsNode,
                controller: _passwordTextEditController,
                nextFocusNode: _passwordFoucsNode,
                obsecureText: obsecureValue,
                obsecureValue: "*",
                suffix: IconButton(
                  onPressed: () =>
                      _obsecurePassword.value = !_obsecurePassword.value,
                  icon: Icon(
                    obsecureValue ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                hintText: "PassWord",
                labalText: "PassWord",
                validator: (value) =>
                    SignupValidation.passwordValidatiion(value),
                textInputType: TextInputType.visiblePassword,
              );
            },
          ),
          const SizedBox(
            height: AppMargin.large,
          ),
          // Submit button================
          SubmitButton(
            isLoading: authViewModel.signUpLoading,
            actionFunction: () {
              if (formkey.currentState!.validate()) {
                final email = _emailTextEditController.text;
                final password = _passwordTextEditController.text;
                final name = _userNameTextEditController.text;
                Map data = {'name': name, 'email': email, 'password': password};
                authViewModel.signUpApi(data, context);
              }
            },
            buttonChildtext: "Submit",
          ),
          const SizedBox(
            height: AppMargin.extraLarge,
          ),
          // Already have an accoount======
          const AlreadyHaveAcc(),
          const SizedBox(
            height: AppMargin.extraLarge,
          ),
        ],
      ),
    );
  }
}
