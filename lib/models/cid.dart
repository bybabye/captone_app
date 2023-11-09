import 'package:json_annotation/json_annotation.dart';

part 'cid.g.dart';

@JsonSerializable()
class CID {
  final String fullName;
  final String no;
  final String image;
  final String sex;
  final String placeOfOrigin;
  final DateTime? dateOfBirth;
  final String placeOfResidence;

  CID({
    this.fullName = "",
    this.no = '',
    this.image = '',
    this.sex = 'nam',
    this.placeOfOrigin = '',
    this.dateOfBirth,
    this.placeOfResidence = '',
  });

  factory CID.fromJson(Map<String, dynamic> json) => _$CIDFromJson(json);

  Map<String, dynamic> toJson() => _$CIDToJson(this);
}
