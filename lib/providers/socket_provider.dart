import 'package:captone_app/constants/api.dart';
import 'package:captone_app/models/message.dart';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketIOProvider extends ChangeNotifier {
  late Socket socket;
  List<Message> messages = [];
  String? uid;
  String? roomChat;
  late ScrollController _scrollController;
  bool isLoadingListMessage = false;

  List<Map<String, dynamic>> activeUsers = [];

  SocketIOProvider() {
    connectToServer();
  }

  void setScrollController(ScrollController scrollController) {
    _scrollController = scrollController;
  }

  void connectToServer() {
    try {
      socket = io(Api.apiSocket, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.on('connect', (_) {
        print('Connected to server');
        socket.emit('add-user', uid);
      });
      socket.on('get-users', (data) {
        activeUsers = List<Map<String, dynamic>>.from(data);
        notifyListeners(); // Thông báo cho người nghe thay đổi trạng thái
      });
      socket.on('chat-id', (data) {
        print("da cap nhat $data");
        messages.add(Message.fromJson(data['message']));

        notifyListeners();
        scrollToBottom();
        // ignore: unnecessary_null_comparison
      });
      socket.on('disconnect', (_) {
        print('Disconnected from server');
      });

      socket.connect();
    } catch (e) {
      print(e);
    }
  }

  void scrollToBottom() {
    // ignore: unnecessary_null_comparison
    if (_scrollController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  sendMessage(String chatId, Map<String, dynamic> message) {
    print("da emit");

    socket.emit('send-message', {
      'chatId': chatId,
      'message': message,
    });

    notifyListeners();
    scrollToBottom();
  }

  listenChatId() {}

  // Thêm một phương thức để thêm tin nhắn vào danh sách và cập nhật giao diện người dùng

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
