import 'dart:convert';
import 'dart:io';
import 'package:albrandz_cbt_p/controllers/data/user_local_data_controller.dart';
import 'package:albrandz_cbt_p/models/api/api_response_model.dart';
import 'package:albrandz_cbt_p/views/screens/login/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:albrandz_cbt_p/views/utils/constants/api_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getPackage;
import 'package:logger/logger.dart';

import '../../views/utils/constants/constants.dart'; // Assuming this contains BASE_URL

class ApiController {
  final logger = Logger();
  final Dio _dio = Dio();

  _getHeaders()async{
    var token = await UserLocalDataController().getLoginToken();
    return {
      AUTHORIZATION: "Bearer $token"
    };
  }
  Map<String, dynamic>? get _defaultHeaders => {};


  // GET request
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams, bool isHeader = false}) async {
    try {
      final response = await _dio.get(
        FULL_URL + endpoint,
        queryParameters: queryParams,
        options: Options(headers: isHeader?await _getHeaders():_defaultHeaders),
      );
      checkTokenStatus(response);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  // POST request
  Future<dynamic> post(String endpoint, {required Map<String, dynamic> data, bool isHeader = false}) async {
    try {
      final response = await _dio.post(
        FULL_URL + endpoint,
        data: data,
        options: Options(headers: isHeader?_getHeaders():_defaultHeaders),
      );
      checkTokenStatus(response);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  // PUT request
  Future<dynamic> put(String endpoint, {required Map<String, dynamic> data, bool isHeader = false}) async {
    try {
      final response = await _dio.put(
        FULL_URL + endpoint,
        data: data,
        options: Options(headers: isHeader?await _getHeaders():_defaultHeaders),
      );
      checkTokenStatus(response);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  // DELETE request
  Future<dynamic> delete(String endpoint, {required Map<String, dynamic> data, bool isHeader = false}) async {
    try {
      final response = await _dio.delete(
        FULL_URL + endpoint,
        data: data,
        options: Options(headers: isHeader?await _getHeaders():_defaultHeaders),
      );
      checkTokenStatus(response);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  // Upload file
   Future<dynamic> uploadFile(String endpoint, File file, {bool isHeader = false,String imageType = "image"}) async {
    var imageByte = file.readAsBytesSync();
    var encodeB4 = base64Encode(imageByte);
    var extension = file.path.split('.').last;
    var prefixUel = "data:$imageType/$extension;base64,";
    try {
      var body = {
        "file":"$prefixUel$encodeB4"
      };

      final response = await _dio.post(
        FULL_URL+endpoint,
        data: body,
        options: Options(headers: isHeader?await _getHeaders():_defaultHeaders),
        onSendProgress: (int sent, int total) {
          print('Upload Progress: ${(sent / total) * 100}%');
        },
      );
      checkTokenStatus(response);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

   Future<dynamic> updateFile(String endpoint, File file, {bool isHeader = false,String imageType = "image"}) async {
    var imageByte = file.readAsBytesSync();
    var encodeB4 = base64Encode(imageByte);
    var extension = file.path.split('.').last;
    var prefixUel = "data:$imageType/$extension;base64,";
    try {
      var body = {
        "file":"$prefixUel$encodeB4"
      };

      final response = await _dio.put(
        FULL_URL+endpoint,
        data: body,
        options: Options(headers: isHeader?await _getHeaders():_defaultHeaders),
        onSendProgress: (int sent, int total) {
          print('Upload Progress: ${(sent / total) * 100}%');
        },
      );
      checkTokenStatus(response);
      return handleResponse(response);
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  // Method to download a file
  Future<void> downloadFile(String endpoint, String savePath, {bool isHeader = false}) async {
    try {
      final response = await _dio.download(
        FULL_URL+endpoint,
        savePath,
        options: Options(headers: isHeader?await _getHeaders():_defaultHeaders),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('Download Progress: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );
      checkTokenStatus(response);
      if (response.statusCode == 200) {
        print('File downloaded successfully!');
      } else {
        print('Failed to download file with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('File download error: $error');
    }
  }

  // Handle Dio exceptions
  dynamic handleError(DioException e) {
    if (e.response != null) {
      print('Dio error: ${e.response?.data}');
      logger.d(e.response?.statusCode);
      return handleResponse(e.response!);
    } else {
      if (e.error is SocketException) {
        print('No Internet connection');
        logger.d(e.response?.statusCode);
      } else {
        print('Unknown error: ${e.message}');
        logger.d(e.message);
      }
      return null;
    }
  }
  // Helper method to handle response codes and errors
  dynamic handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data; // Success
      case 400:
        print('Bad request: ${response.data}');
        logger.d("Bad request ${response.data}");
        break;
      case 401:
        print('Unauthorized: ${response.data}');
        logger.d("Unauthorized ${response.data}");
        break;
      case 403:
        print('Forbidden: ${response.data}');
        logger.d("Forbidden ${response.data}");
        break;
      case 404:
        print('Not found: ${response.data}');
        logger.d("Note found ${response.data}");
        break;
      case 500:
        print('Internal Server Error: ${response.data}');
        logger.d("Internal Server Error: ${response.data}");
        break;
      default:
        print('Unknown error: ${response.data}');
        logger.d("Unknown error: ${response.data}");
    }
    return null;
  }

  checkTokenStatus(Response<dynamic> response){
    var data = ApiResponseModel.fromJson(response.data as Map<String,dynamic>);
    if(data.response?.status == FAILED_s && data.response?.message == TOKEN_ERROR){
      getPackage.Get.offUntil(getPackage.GetPageRoute(page: ()=>const LoginScreen()),ModalRoute.withName('/login'));
    }
  }
}
