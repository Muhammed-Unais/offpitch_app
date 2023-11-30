import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/src/bottom_bar/view_model/bottom_bar_viewmodel.dart';
import 'package:offpitch_app/src/login/repository/auth_repository.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/src/splash/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {
  final _myrepo = AuthRepository();
  var userPrefrence = UserViewModel();

  String? _confirmationToken;

  bool _isloading = false;
  bool get isloading => _isloading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  bool _forgotPasResetLoading = false;
  bool get forgotPasResetLoading => _forgotPasResetLoading;

  bool _otpVerifyIsLoading = false;
  bool get otpVerifyIsLoading => _otpVerifyIsLoading;

  void setOtpVerifyLoading(bool value) {
    _otpVerifyIsLoading = value;
    notifyListeners();
  }

  void setForgotPasResetLoading(bool value) {
    _forgotPasResetLoading = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void setSingupLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(data, BuildContext context) async {
    setLoading(true);

    _myrepo.loginApi(data).then(
      (value) async {
        setLoading(false);
        userPrefrence.saveAcesssToken(value: value.data?.accessToken ?? "");

        userPrefrence.saveUserClubId(value);

        Utils.showToastMessage(value.message ?? "");

        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.navigation,
          (route) => false,
        );
        Provider.of<BottomBarViewModel>(context, listen: false)
            .onTap(0, context);
      },
    ).onError(
      (error, stackTrace) async {
        setLoading(false);
        Utils.showCustomFlushbar(context, error.toString());
      },
    );
  }

  // forgott password======
  Future<void> forgotPassword(BuildContext context, data) async {
    setForgotPasResetLoading(true);
    _myrepo.forgotPasswordApi(data).then((value) {
      setForgotPasResetLoading(false);
      log(value.toString());
      Map<String, dynamic> message = value;
      Utils.showCustomFlushbar(context, message["message"], isError: false);
    }).onError((error, stackTrace) {
      Utils.showCustomFlushbar(context, error.toString());
      setForgotPasResetLoading(false);
      log(error.toString());
    });
  }

  // SignupApi=============
  Future<void> signUpApi(data, BuildContext context) async {
    setSingupLoading(true);
    _myrepo.signupApi(data).then(
      (value) {
        setSingupLoading(false);

        var message = value as Map<String, dynamic>;
        _confirmationToken = message['data']['confirmToken'];

        Utils.showToastMessage(message["message"]);
        Navigator.pushNamed(context, RoutesName.otp);
      },
    ).onError(
      (error, stackTrace) {
        setSingupLoading(false);
        Utils.showCustomFlushbar(context, error.toString());
      },
    );
  }

  Future<void> otpVerifyApi(String otp, BuildContext context) async {
    setOtpVerifyLoading(true);

    Map<String, dynamic> otpCredential = {
      "otp": otp,
      "token": _confirmationToken,
    };

    _myrepo.otpVerifyApi(otpCredential).then((value) {
      setOtpVerifyLoading(false);

      userPrefrence.saveAcesssToken(value: value.data?.accessToken ?? "");

      Utils.showToastMessage(value.message ?? "");

      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.navigation,
        (route) => false,
      );

      Provider.of<BottomBarViewModel>(context, listen: false).onTap(0, context);
    }).onError((error, stackTrace) {
      setOtpVerifyLoading(false);
      Utils.showCustomFlushbar(context, error.toString());
    });
  }

  Future<void> resendOtp(BuildContext context) async {
    setSingupLoading(true);
    _myrepo.resendOtp(_confirmationToken).then(
      (value) {
        Map<String, dynamic> message = value;
        _confirmationToken = message['data']['confirmToken'];
        setSingupLoading(false);
        Utils.showToastMessage(message["message"]);
      },
    ).onError(
      (error, stackTrace) {
        setSingupLoading(false);
        Utils.showCustomFlushbar(context, error.toString());
      },
    );
  }

  Future userlogout() async {
    _myrepo.userLogout().then(
      (value) {
        log(value.toString());
      },
    ).onError(
      (error, stackTrace) {
        log(error.toString());
      },
    );
  }
}
