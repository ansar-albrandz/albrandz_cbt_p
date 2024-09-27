import 'dart:convert';

CreateProfileModel createProfileModelFromJson(String str) => CreateProfileModel.fromJson(json.decode(str));

String createProfileModelToJson(CreateProfileModel data) => json.encode(data.toJson());

class CreateProfileModel {
  String? name;
  String? email;
  String? dob;
  String? gender;
  String? pin;

  CreateProfileModel({
    this.name,
    this.email,
    this.dob,
    this.gender,
    this.pin,
  });

  factory CreateProfileModel.fromJson(Map<String, dynamic> json) => CreateProfileModel(
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
