import 'dart:convert';

OtpResponseModel otpResponseModelFromJson(String str) => OtpResponseModel.fromJson(json.decode(str));

String otpResponseModelToJson(OtpResponseModel data) => json.encode(data.toJson());

class OtpResponseModel {
  OTPResponseData? response;
  String? header;

  OtpResponseModel({
    this.response,
    this.header,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) => OtpResponseModel(
    response: json["response"] == null ? null : OTPResponseData.fromJson(json["response"]),
    header: json["header"],
  );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
    "header": header,
  };
}

class OTPResponseData {
  String? status;
  String? message;

  OTPResponseData({
    this.status,
    this.message,
  });

  factory OTPResponseData.fromJson(Map<String, dynamic> json) => OTPResponseData(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
