// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      mid: json['_id'] as String,
      chatId: json['chatId'] as String,
      content: json['content'] as String,
      sentTime: json['sentTime'] as String,
      senderId: json['senderId'] as String,
      type: $enumDecodeNullable(_$TypeMessageEnumMap, json['type']) ??
          TypeMessage.text,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'mid': instance.mid,
      'chatId': instance.chatId,
      'type': _$TypeMessageEnumMap[instance.type]!,
      'content': instance.content,
      'senderId': instance.senderId,
      'sentTime': instance.sentTime,
    };

const _$TypeMessageEnumMap = {
  TypeMessage.text: 'text',
  TypeMessage.video: 'video',
  TypeMessage.image: 'image',
  TypeMessage.voice: 'voice',
};
