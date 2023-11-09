// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationApp _$NotificationAppFromJson(Map<String, dynamic> json) =>
    NotificationApp(
      id: json['_id'] as String,
      senderId: UserApp.fromJson(json['senderId'] as Map<String, dynamic>),
      receiverId: json['receiverId'] as String,
      target: json['target'] as String,
      targetId: json['targetId'] as String,
      content: json['content'] as String,
      read: json['read'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: json['__v'] as int,
    );

Map<String, dynamic> _$NotificationAppToJson(NotificationApp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'target': instance.target,
      'targetId': instance.targetId,
      'content': instance.content,
      'read': instance.read,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'v': instance.v,
    };
