import 'package:captone_app/models/message.dart';
import 'package:captone_app/providers/auth_provider.dart';
import 'package:captone_app/providers/chat_provider.dart';
import 'package:captone_app/providers/socket_provider.dart';

import 'package:captone_app/theme/app_styles.dart';
import 'package:captone_app/widgets/custom_messages_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage(
      {super.key,
      required this.yId,
      required this.chatId,
      this.avatar = '',
      required this.userName});
  final String chatId;
  final String yId;
  final String avatar;
  final String userName;
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late double height;
  late double width;
  final TextEditingController _controller = TextEditingController();
  late ChatProvider _chat;
  late AuthencationProvider _auth;
  late SocketIOProvider _socketIO;
  bool _isLoading = true;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // sau khi tac vu hoan thanh ms goi toi loadMessage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Thực hiện các tác vụ sau khi widget hoàn thành
      _loadMessages();
      _socketIO.setScrollController(_scrollController);
      //_socketIO.scrollToBottom();
    });
  }

  String convertTimeToAgo(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();

    const locale = 'vi'; // Chọn ngôn ngữ bạn muốn sử dụng, ở đây là tiếng Việt

    return timeago.format(dateTime, locale: locale);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await _chat.listMessages(
        token: _auth.idToken ?? '',
        chatId: widget.chatId,
      );

      // Cập nhật trạng thái và dữ liệu sau khi tải xong
      setState(() {
        _socketIO.messages = messages!;
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } catch (error) {
      // Xử lý lỗi nếu có
      print("Error loading messages: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _chat = Provider.of<ChatProvider>(context);
    _socketIO = Provider.of<SocketIOProvider>(context);
    _auth = Provider.of<AuthencationProvider>(context);
    _socketIO.uid = _auth.user.id;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.avatar == ""
                    ? "https://cdn-icons-png.flaticon.com/512/3177/3177440.png"
                    : widget.avatar),
              ),
            ),
            Text(
              widget.userName,
              style: AppStyles.h2.copyWith(color: Colors.black),
            )
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Iconsax.video,
              size: 30,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              SizedBox(
                  height: height * 0.8,
                  width: width,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: _socketIO.messages.length,
                          itemBuilder: (context, index) {
                            Message message = _socketIO.messages[index];
                            return CustomMessageText(
                              isUser: message.senderId == _auth.user.id,
                              avatar: widget.avatar == ""
                                  ? "https://cdn-icons-png.flaticon.com/512/3177/3177440.png"
                                  : widget.avatar,
                              time: convertTimeToAgo(message.sentTime),
                              text: message.content,
                            );
                          },
                        )),
              Container(
                height: height * 0.1,
                width: width,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(18),
                        padding: const EdgeInsets.all(12),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xFFF2F2F2),
                        ),
                        child: TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Message"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(Iconsax.camera),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          if (_controller.text.isNotEmpty) {
                            await _chat.sendMessage(
                              content: _controller.text,
                              type: TypeMessage.text.name,
                              senderId: _auth.user.id,
                              token: _auth.idToken!,
                              chatId: widget.chatId,
                            );

                            _socketIO.sendMessage(widget.chatId, {
                              "content": _controller.text,
                              "type": TypeMessage.text.name,
                              "senderId": _auth.user.id,
                              "_id": widget.chatId,
                            });
                            setState(() {
                              _controller.text = "";
                            });
                          }
                        },
                        child: const Icon(
                          Iconsax.send1,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
