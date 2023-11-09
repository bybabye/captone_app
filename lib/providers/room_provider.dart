import 'package:captone_app/constants/api.dart';
import 'package:captone_app/models/home.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RoomProvider extends ChangeNotifier {
  bool isLoading = false;
  late final Dio dio;
  List<Home>? homes;

  RoomProvider() {
    BaseOptions options = BaseOptions(
      baseUrl: "http://192.168.0.112:4000",
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    );
    dio = Dio(options);

    listHome();
  }

  Future<void> listHome() async {
    isLoading = true;
    notifyListeners();
    try {
      Response response;
      response = await dio.get(Api.listHome);

      final data = response.data as List;

      homes = data.map((home) => Home.fromJson(home)).toList();
    } catch (e) {
      // ignore: avoid_print
      print('lỗi ở 33 phần room : $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
