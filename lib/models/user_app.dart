import 'package:captone_app/models/cid.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_app.g.dart';

enum Roles { user, admin, host }

@JsonSerializable()
class UserApp {
  final String uid;
  final String id;
  final String userName;
  final String avatar;
  final String address;
  final String phoneNumber;
  final CID cID;
  final Roles roles;
  final List roomfavorites;

  UserApp({
    required this.userName,
    required this.uid,
    this.avatar = '',
    this.address = '',
    this.phoneNumber = '',
    required this.cID,
    required this.id,
    this.roles = Roles.user,
    this.roomfavorites = const [],
  });
  factory UserApp.fromJson(Map<String, dynamic> json) =>
      _$UserAppFromJson(json);

  Map<String, dynamic> toJson() => _$UserAppToJson(this);
}
