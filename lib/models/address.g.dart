// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      stress: json['stress'] as String? ?? '',
      subDistrict: json['subDistrict'] as String? ?? '',
      district: json['district'] as String? ?? '',
      city: json['city'] as String? ?? '',
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'stress': instance.stress,
      'subDistrict': instance.subDistrict,
      'district': instance.district,
      'city': instance.city,
    };
