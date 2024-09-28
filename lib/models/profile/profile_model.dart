import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  ProfileResponseData? response;
  String? header;
  ProfileBodyData? body;

  ProfileModel({
    this.response,
    this.header,
    this.body,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    response: json["response"] == null ? null : ProfileResponseData.fromJson(json["response"]),
    header: json["header"],
    body: json["body"] == null ? null : ProfileBodyData.fromJson(json["body"]),
  );

}

class ProfileBodyData {
  String? mobile;
  ProfileRegistrationData? registration;
  ProfileStatusData? status;
  ProfilePersonalData? personal;
  ProfileDocumentData? document;

  ProfileBodyData({
    this.mobile,
    this.registration,
    this.status,
    this.personal,
    this.document,
  });

  factory ProfileBodyData.fromJson(Map<String, dynamic> json) => ProfileBodyData(
    mobile: json["mobile"],
    registration: json["registration"] == null ? null : ProfileRegistrationData.fromJson(json["registration"]),
    status: json["status"] == null ? null : ProfileStatusData.fromJson(json["status"]),
    personal: json["personal"] == null ? null : ProfilePersonalData.fromJson(json["personal"]),
    document: json["document"] == null ? null : ProfileDocumentData.fromJson(json["document"]),
  );
}

class ProfileDocumentData {
  ProfilePassengerData? passenger;

  ProfileDocumentData({
    this.passenger,
  });

  factory ProfileDocumentData.fromJson(Map<String, dynamic> json) => ProfileDocumentData(
    passenger: json["passenger"] == null ? null : ProfilePassengerData.fromJson(json["passenger"]),
  );

}

class ProfilePassengerData {
  ProfilePhotoData? photo;

  ProfilePassengerData({
    this.photo,
  });

  factory ProfilePassengerData.fromJson(Map<String, dynamic> json) => ProfilePassengerData(
    photo: json["photo"] == null ? null : ProfilePhotoData.fromJson(json["photo"]),
  );
}

class ProfilePhotoData {
  String? file;

  ProfilePhotoData({
    this.file,
  });

  factory ProfilePhotoData.fromJson(Map<String, dynamic> json) => ProfilePhotoData(
    file: json["file"],
  );
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

class ProfileRegistrationData {
  String? date;
  String? id;

  ProfileRegistrationData({
    this.date,
    this.id,
  });

  factory ProfileRegistrationData.fromJson(Map<String, dynamic> json) => ProfileRegistrationData(
    date: json["date"],
    id: json["id"],
  );
}

class ProfileStatusData {
  String? login;
  String? account;

  ProfileStatusData({
    this.login,
    this.account,
  });

  factory ProfileStatusData.fromJson(Map<String, dynamic> json) => ProfileStatusData(
    login: json["login"],
    account: json["account"],
  );
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