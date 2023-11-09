import 'package:captone_app/pages/message_page.dart';
import 'package:captone_app/providers/auth_provider.dart';
import 'package:captone_app/providers/chat_provider.dart';
import 'package:captone_app/routers/navigation_service.dart';
import 'package:captone_app/theme/app_styles.dart';
import 'package:captone_app/widgets/custom_floatting_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatProvider _chat;
  late AuthencationProvider _auth;
  final NavigationService navigationService =
      GetIt.instance.get<NavigationService>();

  @override
  Widget build(BuildContext context) {
    _chat = Provider.of<ChatProvider>(context);
    _auth = Provider.of<AuthencationProvider>(context);

    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Chat",
            style: AppStyles.h2.copyWith(color: Colors.black),
          ),
        ),
        floatingActionButton: const CustomFloatingButton(),
        body: FutureBuilder(
          future: _chat.listChat(token: _auth.idToken!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  //Map<String,dynamic> yId = {} // {_id : "",userName : "",uid: "",avatar: ""}
                  Map<String, dynamic> yId = snapshot.data![index]['membersId']
                      .firstWhere((element) => element['uid'] != _auth.user.uid,
                          orElse: () => null);
                  return InkWell(
                    onTap: () async {
                      navigationService.navigateToPage(MessagePage(
                        yId: yId['_id'],
                        chatId: snapshot.data![index]['_id'],
                        userName: yId['userName'],
                        avatar: yId['avatar'] ?? "",
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(yId['avatar']),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              yId['userName'],
                              style: AppStyles.h3.copyWith(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
