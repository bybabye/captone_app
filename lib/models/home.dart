import 'package:captone_app/models/address.dart';
import 'package:captone_app/models/user_app.dart';

import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class Home {
  final String homeId;
  final double price;
  final double roomArea;
  final List utilities;
  final String roomType;
  final List des;
  final List images;
  final bool status;
  final Address address;
  final UserApp ownerId;

  Home(
      {required this.homeId,
      this.price = 0,
      this.roomArea = 0,
      this.utilities = const [],
      this.roomType = "",
      this.des = const [],
      this.images = const [],
      required this.address,
      this.status = false,
      required this.ownerId});

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
}
