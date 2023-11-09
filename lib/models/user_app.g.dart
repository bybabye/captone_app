// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApp _$UserAppFromJson(Map<String, dynamic> json) => UserApp(
      userName: json['userName'] as String,
      uid: json['uid'] as String,
      avatar: json['avatar'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      cID: CID.fromJson(json['cID'] as Map<String, dynamic>),
      id: json['_id'] as String,
      roles: $enumDecodeNullable(_$RolesEnumMap, json['roles']) ?? Roles.user,
      roomfavorites: json['roomfavorites'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$UserAppToJson(UserApp instance) => <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'userName': instance.userName,
      'avatar': instance.avatar,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'cID': instance.cID,
      'roles': _$RolesEnumMap[instance.roles]!,
      'roomfavorites': instance.roomfavorites,
    };

const _$RolesEnumMap = {
  Roles.user: 'user',
  Roles.admin: 'admin',
  Roles.host: 'host',
};
