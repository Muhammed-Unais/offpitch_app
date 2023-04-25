import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/user_model.dart';
import 'package:offpitch_app/repository/auth_repository.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view_model/services.dart/auth_validation/login_validation.dart';
import 'package:offpitch_app/view_model/services.dart/auth_validation/otp_validation.dart';
import 'package:offpitch_app/view_model/services.dart/auth_validation/signup_validation.dart';
import 'package:offpitch_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {
  final _myrepo = AuthRepository();

  String? confirmationToken;

  bool _isloading = false;
  bool get isloading => _isloading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  bool _forgotPasResetLoading = false;
  bool get forgotPasResetLoading => _forgotPasResetLoading;

  bool _otpVerifyIsLoading = false;
  bool get otpVerifyIsLoading => _otpVerifyIsLoading;

  setOtpVerifyLoading(bool value) {
    _otpVerifyIsLoading = value;
    notifyListeners();
  }

  setForgotPasResetLoading(bool value) {
    _forgotPasResetLoading = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  setSingupLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  // loginApi===========
  Future<void> loginApi(data, BuildContext context) async {
    setLoading(true);

    _myrepo.loginApi(data).then(
      (value) async{
        setLoading(false);
        log(value.toString());
        // saveToken to Sharedpreference
        final userPrefrence =
            Provider.of<UserViewModel>(context, listen: false);
        userPrefrence.saveToken(
          UserModel(
            data: Data(
              accessToken: value['data']['accessToken'],
            ),
          ),
        );
         Navigator.pushReplacementNamed(context, RoutesName.navigation);
      },
    ).onError(
      (error, stackTrace) async {
        setLoading(false);
         log(error.toString());
        // display errors
        
        LoginValidation.loginErrorDisplay(context, error);
       
      },
    );
  }

  // forgott password======
  Future<void> forgotPassword(BuildContext context, data) async {
    setForgotPasResetLoading(true);
    _myrepo.forgotPasswordApi(data).then((value) {
      setForgotPasResetLoading(false);
      log(value.toString());
      final message = value["message"];
      Utils.showFlushbarErrorMessage(
          message: message, context: context, isError: false);
    }).onError((error, stackTrace) {
      setForgotPasResetLoading(false);
      log(error.toString());
    });
  }

  // SignupApi=============
  Future<void> signUpApi(data, BuildContext context) async {
    setSingupLoading(true);
    _myrepo.signupApi(data).then(
      (value) {
        confirmationToken = value['data']['confirmToken'];
        setSingupLoading(false);
        log(value.toString());
        Navigator.pushNamed(context, RoutesName.otp);
      },
    ).onError(
      (error, stackTrace) {
        setSingupLoading(false);
        log(error.toString());
        // display error
        SignupValidation.signupErrorDisplay(context, error);
      },
    );
  }

  // Otp verify Api==============
  Future<void> otpVerifyApi(otp, BuildContext context) async {
    setOtpVerifyLoading(true);
    Map data = {
      "otp": otp,
      "token": confirmationToken,
    };
    _myrepo.otpVerifyApi(data).then((value) async {
      setOtpVerifyLoading(false);
      // saveToken to Sharedpreference

      final userPrefrence = Provider.of<UserViewModel>(context, listen: false);
      userPrefrence.saveToken(
        UserModel(
          data: Data(
            accessToken: value['data']['accessToken'],
          ),
        ),
      );
      log(value.toString());
      Navigator.pushReplacementNamed(context, RoutesName.navigation);
    }).onError((error, stackTrace) {
      OtpValidation.otpErrorDisplay(context, error);
      setOtpVerifyLoading(false);
      log(error.toString());
    });
  }  
}
