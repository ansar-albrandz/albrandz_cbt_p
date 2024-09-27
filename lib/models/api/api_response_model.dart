import 'dart:convert';

ApiResponseModel apiResponseModelFromJson(String str) => ApiResponseModel.fromJson(json.decode(str));

String apiResponseModelToJson(ApiResponseModel data) => json.encode(data.toJson());

class ApiResponseModel {
  APIResponseData? response;

  ApiResponseModel({
    this.response,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) => ApiResponseModel(
    response: json["response"] == null ? null : APIResponseData.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
  };
}

class APIResponseData {
  String? status;
  String? message;

  APIResponseData({
    this.status,
    this.message,
  });

  factory APIResponseData.fromJson(Map<String, dynamic> json) => APIResponseData(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
