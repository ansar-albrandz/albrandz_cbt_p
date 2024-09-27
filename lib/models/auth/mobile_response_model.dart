// To parse this JSON data, do
//
//     final mobileResponseModel = mobileResponseModelFromJson(jsonString);

import 'dart:convert';

MobileResponseModel mobileResponseModelFromJson(String str) => MobileResponseModel.fromJson(json.decode(str));

String mobileResponseModelToJson(MobileResponseModel data) => json.encode(data.toJson());

class MobileResponseModel {
  Response? response;

  MobileResponseModel({
    this.response,
  });

  factory MobileResponseModel.fromJson(Map<String, dynamic> json) => MobileResponseModel(
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
  };
}

class Response {
  String? status;
  String? message;

  Response({
    this.status,
    this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
