import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/main.dart';
import 'package:offpitch_app/models/registration_model.dart';
import 'package:offpitch_app/models/registration_save_fee_model.dart';
import 'package:offpitch_app/repository/registration_repository.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RegistorationViewModel with ChangeNotifier {
  final _myrepo = RegistrationRepository();
  bool isPermission = false;

  final razorPayKey = "rzp_test_yrNP9XZJenorHu";
  final razorPaySecret = "";
  String? paymentId;
  String? orderId;
  String? signature;
  String? tournamentIdforSavePay;

  setPermission(bool isApprove) {
    isPermission = isApprove;
    notifyListeners();
  }

  final Razorpay _razorpay = Razorpay(); //Instance of razor pay

  intiateRazorPay() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    orderId = response.orderId;
    signature = response.signature;

    postPaymentSave(
      razorpayPaymentId: paymentId,
      razorpayOrderId: orderId,
      razorpaySignature: signature,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utils.showToastMessage("Error:${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utils.showToastMessage("External Wallet:${response.walletName}");
  }

  openSession({required num amount, required String orderId}) {
    var options = {
      'key': razorPayKey,
      'amount': amount,
      'name': 'Company Name',
      'order_id': orderId,
      'description': 'Description for order',
      'timeout': 60,
      'prefill': {
        'contact': '9123456789',
        'email': 'flutterwings304@gmail.com',
      }
    };
    try {
      _razorpay.open(options);
      intiateRazorPay();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // details Page registration =================
  String dobToAge(DateTime dobs) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    DateTime dob = DateTime(dobs.year, dobs.month, dobs.day);
    Duration difference = date.difference(dob);
    int ageInDays = difference.inDays;
    int ageInYears = (ageInDays / 365).floor();
    return ageInYears.toString();
  }

  List<String> playersIds = [];
  playersAddingcheckbox(bool value, index, BuildContext context) {
    final myclub = Provider.of<MyClubViewModel>(context, listen: false);
    myclub.selectedPlayers[index] = value;
    notifyListeners();
  }

  // Post Registration Api call===================================
  postRegisterTournament(id, context) async {
    tournamentIdforSavePay = id;
    final value = playersIds;
    final data = RegistrationTour(players: value);
    _myrepo.postRegistration(id, data).then((value) {
      if (value.data?.amount == null) {
        return;
      }
      if (value.data!.amount! > 0) {
        openSession(amount: value.data!.amount!, orderId: value.data!.orderId!);
      }
      Provider.of<DetailsTouramentViewModel>(context, listen: false)
          .getSingleTournament(id,);
      Navigator.pop(context);
      Utils.showCustomFlushbar(context, value.message!);
    }).onError((error, stackTrace) {
      Utils.showCustomFlushbar(context, error.toString());
      log(error.toString());
    });
  }

  postPaymentSave(
      {required String? razorpayPaymentId,
      razorpayOrderId,
      razorpaySignature}) async {
    final data = RegistrationSaveFeeModel(
        razorpayPaymentId: paymentId,
        razorpayOrderId: orderId,
        razorpaySignature: signature);
    log("success post save payment");
    await _myrepo.postPaymentSave(tournamentIdforSavePay, data).then((value) {
      log(value.toString());
      navigatorKey.currentState?.pushNamed(RoutesName.paymentSuccespage);
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  clearAllDataLogout() {
    paymentId = null;
    orderId = null;
    signature = null;
    tournamentIdforSavePay = null;
  }
}
