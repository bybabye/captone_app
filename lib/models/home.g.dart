// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) => Home(
      homeId: json['_id'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      roomArea: (json['roomArea'] as num?)?.toDouble() ?? 0,
      utilities: json['utilities'] as List<dynamic>? ?? const [],
      roomType: json['roomType'] as String? ?? "",
      des: json['des'] as List<dynamic>? ?? const [],
      images: json['images'] as List<dynamic>? ?? const [],
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      status: json['status'] as bool? ?? false,
      ownerId: UserApp.fromJson(json['ownerId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'homeId': instance.homeId,
      'price': instance.price,
      'roomArea': instance.roomArea,
      'utilities': instance.utilities,
      'roomType': instance.roomType,
      'des': instance.des,
      'images': instance.images,
      'status': instance.status,
      'address': instance.address,
      'ownerId': instance.ownerId,
    };
