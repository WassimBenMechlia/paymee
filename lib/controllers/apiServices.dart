import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:paymee/controllers/ApiException.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class APIService {
  Dio dio = Dio();

  Future<String> requestCodeForRegister(String data) async {
    try {
      Response response = await dio.post(AppConstants.sendSMS, data: data);
      Map<String, dynamic> json = response.data;
      final dataList = json['data'] as List;
      final hash = dataList.first['hash'] as String;
      return hash;
    } on DioError catch (e) {
      List<dynamic> list = e.response!.data['errors'];
      String user = list.first['user'] as String;
      throw ApiException(user);
    }
  }

  Future<String> verifyCodeForRegister(String data) async {
    try {
      Response response =
          await dio.post(AppConstants.verifySMSCode, data: data);
      Map<String, dynamic> json = response.data;
      final msg = json['message'] as String;

      return msg;
    } on DioError catch (e) {
      List lst = e.response!.data['errors'];
      final errorMsg = lst.first['code'] as String;
      throw ApiException(errorMsg);
    }
  }

  Future<void> registerNewUser(FormData data) async {
    try {
      Response response = await dio.post(AppConstants.registerNewUser,
          data: data,
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ));
      Map<String, dynamic> userInfo = response.data;
      String token = userInfo['token'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      print('$userInfo-------');
    } on DioError {
      throw ApiException('error');
    }
  }

  Future<void> loginUsingPin(String data, String? token) async {
    try {
      print(token);
      await dio.post(AppConstants.loginWithPin,
          data: data,
          options: Options(contentType: Headers.jsonContentType, headers: {
            HttpHeaders.authorizationHeader: "token ${token!}",
          }));
    } on DioError catch (e) {
      print(e.response?.data.toString());
      throw ApiException(e.message);
    }
  }

  Future<String> requestCodeForLogin(String data) async {
    try {
      Response response = await dio.post(AppConstants.sendSMSLogin, data: data);
      Map<String, dynamic> json = response.data;
      String hash = json['data'];
      return hash;
    } on SocketException catch (e) {
      throw ApiException(e.message);
    } on DioError catch (e) {
      String errorMsg;
      final response = e.response;

      if (response?.data['errors'] != null) {
        List error = response?.data['errors'];

        if (error.first['error'] == "Erreur d'authetification") {
          errorMsg = "Le numéro de téléphone ou le mot de passe est incorrect";
        } else {
          errorMsg = error.toString();
        }
        throw ApiException(errorMsg);
      }
      throw ApiException('Unknown error');
    }
  }

  Future<void> confirmCodeForLogin(String data) async {
    try {
      Response response = await dio.post(
        AppConstants.confirmLogin,
        data: data,
      );

      Map<String, dynamic> json = response.data;
      String jsonString = jsonEncode(json);
      print(jsonString);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('response', jsonString);
    } on DioError {
      throw ApiException('Unknown error');
    }
  }

  Future<void> completeFiles(FormData data, String? token) async {
    try {
      Response response = await dio.patch(AppConstants.completeDocs,
          data: data,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            HttpHeaders.authorizationHeader: "token $token",
          }));
      print(response.data.toString());
      print(response.statusCode.toString());
    } on DioError {
      throw ApiException('unable to upload missing files');
    }
  }

  Future<void> sheckMail(String data) async {
    try {
      await dio.post(AppConstants.sheckEmail, data: data);
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message']);
    }
  }
}
