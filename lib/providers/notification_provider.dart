import 'package:captone_app/constants/api.dart';
import 'package:captone_app/models/notification_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  late final Dio dio;

  NotificationProvider() {
    dio = Dio();
  }

  Future<List<NotificationApp>> listNotification(idToken) async {
    List<NotificationApp> notifis = [];
    Response response;
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $idToken',
      };
      response = await dio.get(Api.getListNotification,
          options: Options(headers: headers));
      if (response.data != null) {
        final data = response.data;

        data['data'].map((notifi) {
          NotificationApp noti = NotificationApp.fromJson(notifi);
          notifis.add(noti);
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return notifis;
  }

  Future<String> addNotification(
      {required String idToken,
      required String content,
      required String targetId,
      required String target,
      required String receiverId}) async {
    String result = "";

    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $idToken',
      };
      await dio.post(
        Api.addNotification,
        data: {
          'receiverId': receiverId,
          'target': target,
          'targetId': targetId,
          'content': content,
        },
        options: Options(headers: headers),
      );

      result = "Đã gửi thông báo cho chủ nhà!! Hãy chờ hồi đáp nhé";
    } catch (e) {
      print(e);

      result = "Đã có lỗi xảy ra ! Phản hồi thất bại!";
    }
    return result;
  }

  Future<void> readNotification(
      {required String idToken, required String idNotification}) async {
    try {
      Response response;
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $idToken',
      };
      print("${Api.readNotification}?notifiId=$idNotification");
      response = await dio.patch(
        "${Api.readNotification}?notifiId=$idNotification",
        options: Options(headers: headers),
      );
      final data = response.data;
      print(data);
    } catch (e) {
      print(e);
    }
  }
}
