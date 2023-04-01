import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/user_model.dart';
import 'package:offpitch_app/repository/auth_repository.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _isloading = false;
  bool get isloading => _isloading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  setSingupLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(data, BuildContext context) async {
    setLoading(true);

    _myrepo.loginApi(data).then((value) {
      setLoading(false);

      final userPrefrence = Provider.of<UserViewModel>(context, listen: false);
      // saveToken to Sharedpreference
      userPrefrence.saveToken(
          UserModel(data: Data(accessToken: value['data']['accessToken'])));
      Navigator.pushNamed(context, RoutesName.home);

    }).onError((error, stackTrace) async {
      setLoading(false);

      // socket exception
      if (error.toString().contains("No Internet connection")) {
        Utils.showFlushbarErrorMessage(
            message: "No Internet connection", context: context);
      }

      // default somthing went wrong
      else if(error.toString().contains("error occured while communicating with server")){
         Utils.showFlushbarErrorMessage(
            message: "Something went wrong", context: context);
      }

      // exception message from server 
       else {
        String invalidError = error.toString();
        RegExp regExp = RegExp(r'({.*})');
        RegExpMatch? match = regExp.firstMatch(invalidError);
        String? jsonString = match!.group(0);
        final Map<String, dynamic> errorJson = jsonDecode(jsonString!);
        log(errorJson.toString());
        Utils.showFlushbarErrorMessage(
            message: errorJson['message'], context: context);
      }
    });
  }

  Future<void> signUpApi(data, BuildContext context) async {
    setSingupLoading(true);
    _myrepo.signupApi(data).then((value) {
      setSingupLoading(false);
      Navigator.pushNamed(context, RoutesName.home);
      log(value.toString());
    }).onError((error, stackTrace) {
      setSingupLoading(false);
      log(error.toString());
    });
  }
}
