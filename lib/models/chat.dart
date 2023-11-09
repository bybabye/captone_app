import 'package:json_annotation/json_annotation.dart';
part 'chat.g.dart';

enum TypeChat { private, gruop }

@JsonSerializable()
class Chat {
  final String chatId;
  final List<String> members;
  final TypeChat typeChat;

  Chat({
    required this.chatId,
    this.members = const [],
    this.typeChat = TypeChat.private,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
