import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String stress;
  final String subDistrict;
  final String district;
  final String city;
  Address({
    this.stress = '',
    this.subDistrict = '',
    this.district = '',
    this.city = '',
  });
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
