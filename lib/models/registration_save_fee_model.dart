
import 'dart:convert';

RegistrationSaveFeeModel registrationSaveFeeModelFromJson(String str) => RegistrationSaveFeeModel.fromJson(json.decode(str));

String registrationSaveFeeModelToJson(RegistrationSaveFeeModel data) => json.encode(data.toJson());

class RegistrationSaveFeeModel {
    String? razorpayPaymentId;
    String? razorpayOrderId;
    String? razorpaySignature;

    RegistrationSaveFeeModel({
        this.razorpayPaymentId,
        this.razorpayOrderId,
        this.razorpaySignature,
    });

    factory RegistrationSaveFeeModel.fromJson(Map<String, dynamic> json) => RegistrationSaveFeeModel(
        razorpayPaymentId: json["razorpay_payment_id"],
        razorpayOrderId: json["razorpay_order_id"],
        razorpaySignature: json["razorpay_signature"],
    );

    Map<String, dynamic> toJson() => {
        "razorpay_payment_id": razorpayPaymentId,
        "razorpay_order_id": razorpayOrderId,
        "razorpay_signature": razorpaySignature,
    };
}
