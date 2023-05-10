import 'dart:convert';

RegistrationFeeModel registrationFeeModelFromJson(Map<String,dynamic> data) => RegistrationFeeModel.fromJson(data);

String registrationFeeModelToJson(RegistrationFeeModel data) => json.encode(data.toJson());

class RegistrationFeeModel {
    bool? success;
    String? message;
    Data? data;

    RegistrationFeeModel({
        this.success,
        this.message,
        this.data,
    });

    factory RegistrationFeeModel.fromJson(Map<String, dynamic> json) => RegistrationFeeModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? amount;
    String? orderId;

    Data({
        this.amount,
        this.orderId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        amount: json["amount"],
        orderId: json["order_id"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "order_id": orderId,
    };
}