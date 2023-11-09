// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      chatId: json['_id'] as String,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      typeChat: $enumDecodeNullable(_$TypeChatEnumMap, json['typeChat']) ??
          TypeChat.private,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'chatId': instance.chatId,
      'members': instance.members,
      'typeChat': _$TypeChatEnumMap[instance.typeChat]!,
    };

const _$TypeChatEnumMap = {
  TypeChat.private: 'private',
  TypeChat.gruop: 'gruop',
};
