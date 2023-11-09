import 'package:captone_app/models/home.dart';
import 'package:captone_app/models/user_app.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rental.g.dart';

@JsonSerializable()
class Rental {
  final String homeId;
  final String id;
  final UserApp tenantId;
  final double leasePeriod;
  final double cost;
  final DateTime endTime;
  final bool rentalStatus;
  final DateTime createdAt;

  Rental({
    required this.id,
    required this.homeId,
    required this.cost,
    required this.createdAt,
    required this.endTime,
    required this.leasePeriod,
    required this.rentalStatus,
    required this.tenantId,
  });

  factory Rental.fromJson(Map<String, dynamic> json) => _$RentalFromJson(json);

  Map<String, dynamic> toJson() => _$RentalToJson(this);
}
