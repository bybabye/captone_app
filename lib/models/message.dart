import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

enum TypeMessage { text, video, image, voice }

@JsonSerializable()
class Message {
  final String mid;
  final String chatId;
  final TypeMessage type;
  final String content;
  final String senderId;
  final String sentTime;

  Message({
    required this.mid,
    required this.chatId,
    required this.content,
    required this.sentTime,
    required this.senderId,
    this.type = TypeMessage.text,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
