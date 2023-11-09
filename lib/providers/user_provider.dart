import 'package:captone_app/constants/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late final Dio dio;

  UserProvider() {
    BaseOptions options = BaseOptions(
      baseUrl: "http://192.168.0.112:4000",
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    );
    dio = Dio(options);
  }

  Future<String> updateProfile(Map data, String idToken) async {
    String result = "";
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $idToken',
      };
      Response response;
      response = await dio.post(Api.updateProfile,
          data: data, options: Options(headers: headers));
      result = await response.data['message'];
    } catch (e) {
      notifyListeners();
      // ignore: avoid_print
      print('lỗi ở  phần userProfle : $e');
    }

    return result;
  }
}
