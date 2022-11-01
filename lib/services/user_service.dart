import 'dart:developer';

import 'package:dio/dio.dart';

import 'exceptions/api_exception.dart';

abstract class UserService {
  static Future<Map<String, dynamic>> fetchUsers(
      {required int page, required String gender}) async {
    try {
      String baseUrl =
          'https://randomuser.me/api/1.4/?format=json&results=20&inc=gender,email,name,picture&nat=br';
      Response response = await Dio()
          .get(baseUrl, queryParameters: {'page': page, 'gender': gender});
      return response.data as Map<String, dynamic>;
    } on DioError catch (e) {
      if (e.response != null) {
        throw ApiException(code: e.response?.statusCode, message: e.message);
      } else {
        throw ApiException(code: -1, message: e.message);
      }
    }
  }
}
