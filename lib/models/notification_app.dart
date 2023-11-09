import 'package:captone_app/models/user_app.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_app.g.dart';

@JsonSerializable()
class NotificationApp {
  String id;
  UserApp senderId;
  String receiverId;
  String target;
  String targetId;
  String content;
  bool read;
  String createdAt;
  String updatedAt;
  int v;

  NotificationApp({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.target,
    required this.targetId,
    required this.content,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NotificationApp.fromJson(Map<String, dynamic> json) =>
      _$NotificationAppFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationAppToJson(this);
}
