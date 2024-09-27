// To parse this JSON data, do
//
//     final profileResponseModel = profileResponseModelFromJson(jsonString);

import 'dart:convert';

ProfileResponseModel profileResponseModelFromJson(String str) => ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) => json.encode(data.toJson());

class ProfileResponseModel {
  ProfileResponseData? response;
  String? header;
  ProfileBodyData? body;

  ProfileResponseModel({
    this.response,
    this.header,
    this.body,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
    response: json["response"] == null ? null : ProfileResponseData.fromJson(json["response"]),
    header: json["header"],
    body: json["body"] == null ? null : ProfileBodyData.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
    "header": header,
    "body": body?.toJson(),
  };
}

class ProfileBodyData {
  ProfilePersonalData? personal;

  ProfileBodyData({
    this.personal,
  });

  factory ProfileBodyData.fromJson(Map<String, dynamic> json) => ProfileBodyData(
    personal: json["personal"] == null ? null : ProfilePersonalData.fromJson(json["personal"]),
  );

  Map<String, dynamic> toJson() => {
    "personal": personal?.toJson(),
  };
}

class ProfilePersonalData {
  String? name;
  String? email;
  String? dob;
  String? gender;
  String? pin;

  ProfilePersonalData({
    this.name,
    this.email,
    this.dob,
    this.gender,
    this.pin,
  });

  factory ProfilePersonalData.fromJson(Map<String, dynamic> json) => ProfilePersonalData(
    name: json["name"],
    email: json["email"],
    dob: json["dob"],
    gender: json["gender"],
    pin: json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "dob": dob,
    "gender": gender,
    "pin": pin,
  };
}

class ProfileResponseData {
  String? status;
  String? message;

  ProfileResponseData({
    this.status,
    this.message,
  });

  factory ProfileResponseData.fromJson(Map<String, dynamic> json) => ProfileResponseData(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
