// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rental _$RentalFromJson(Map<String, dynamic> json) => Rental(
      id: json['_id'] as String,
      homeId: json['homeId'] as String,
      cost: (json['cost'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      leasePeriod: (json['leasePeriod'] as num).toDouble(),
      rentalStatus: json['rentalStatus'] as bool,
      tenantId: UserApp.fromJson(json['tenantId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RentalToJson(Rental instance) => <String, dynamic>{
      // 'homeId': instance.homeId,
      'id': instance.id,
      'tenantId': instance.tenantId,
      'leasePeriod': instance.leasePeriod,
      'cost': instance.cost,
      'endTime': instance.endTime.toIso8601String(),
      'rentalStatus': instance.rentalStatus,
      'createdAt': instance.createdAt.toIso8601String(),
    };
