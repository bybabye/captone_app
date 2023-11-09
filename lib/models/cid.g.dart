// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CID _$CIDFromJson(Map<String, dynamic> json) => CID(
      fullName: json['fullName'] as String? ?? "",
      no: json['no'] as String? ?? '',
      image: json['image'] as String? ?? '',
      sex: json['sex'] as String? ?? 'nam',
      placeOfOrigin: json['placeOfOrigin'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      placeOfResidence: json['placeOfResidence'] as String? ?? '',
    );

Map<String, dynamic> _$CIDToJson(CID instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'no': instance.no,
      'image': instance.image,
      'sex': instance.sex,
      'placeOfOrigin': instance.placeOfOrigin,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'placeOfResidence': instance.placeOfResidence,
    };
