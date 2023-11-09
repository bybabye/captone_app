import 'dart:async';

import 'package:captone_app/constants/api.dart';
import 'package:captone_app/models/message.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  late final Dio dio;

  ChatProvider() {
    dio = Dio();
  }
  /*
    cần trả về chatId
    id ngườI muốn liên hệ : yId
    Avatar cua người muốn liên hệ 
    userName của người muốn liên hệ
  */
  Future<Map<String, dynamic>?> addChat(
      {required String yid, required token}) async {
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      Response response;
      response = await dio.post(Api.chatAdd,
          data: {
            'senderId': yid,
          },
          options: Options(headers: headers));
      final data = await response.data as Map<String, dynamic>;
      Map<String, dynamic> customData = {
        'yid': "",
        'chatId': "",
        'avatar': "",
        'userName': ""
      };
      customData['chatId'] = data['data']['_id'];
      data['data']['membersId'].forEach((user) => {
            if (user['uid'] == yid)
              {
                customData['yid'] = user['uid'],
                customData['avatar'] = user['avatar'],
                customData['userName'] = user['userName']
              }
          });
      print("custom data $customData");

      return customData;
    } catch (e) {
      print('lỗi ở 33 phần chat : $e');
      return null;
    }
  }

  Future<void> sendMessage(
      {required String content,
      required String type,
      required String senderId,
      required String chatId,
      required String token}) async {
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      Response response;
      response = await dio.post("${Api.sendMess}?chatId=$chatId",
          data: {
            'senderId': senderId,
            'type': type,
            'content': content,
          },
          options: Options(headers: headers));
      final data = await response.data;
      print(data);
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<List<Message>?> listMessages(
      {required String token, required String chatId}) async {
    List<Message> messages = [];
    try {
      // Không có token, thoát khỏi luồng
      if (token == '') return null;
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      Response response;
      response = await dio.get("${Api.getMessage}?chatId=$chatId",
          options: Options(headers: headers));
      final data = await response.data as Map<String, dynamic>;
      print(data);

      data['data']
          .map(
            (message) => messages.add(
              Message.fromJson(message),
            ),
          )
          .toList();
      /**
       * {
       * _id: 6522472b3ba7ce396c82758c, 
       * chatId: 65220620d7a30ef5cd9ff55f, 
       * type: text, 
       * content: hihihaha, 
       * senderId: 64fad036c7a97114a7c9cac5, 
       * sentTime: 08/10/2023 13:07:39, 
       * createdAt: 2023-10-08T06:07:39.041Z, 
       * updatedAt: 2023-10-08T06:07:39.041Z, __v: 0
       * }
       * 
       */
      return messages;
    } catch (e) {
      print("alo alo $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> listChat({required String token}) async {
    try {
      // Không có token, thoát khỏi luồng
      if (token == '') return [];
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };

      Response response;
      response =
          await dio.get(Api.getChats, options: Options(headers: headers));

      final data = await response.data['data'] as List;

      // Chuyển đổi danh sách ban đầu thành danh sách mới với định dạng Map<String, dynamic>
      List<Map<String, dynamic>> chatList =
          data.map((item) => item as Map<String, dynamic>).toList();

      return chatList;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
