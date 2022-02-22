import 'package:crs/models/location.model.dart';
import 'package:crs/models/user.model.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.model.g.dart';

@JsonSerializable()
@HiveType(typeId: Constants.REQUEST_TYPE)
class Request extends HiveObject {
  @HiveField(0)
  DateTime to;

  @HiveField(1)
  DateTime from;

  @HiveField(2)
  List<Location> locations;

  @HiveField(3)
  String message;

  @HiveField(4)
  String status;

  @HiveField(5)
  User client;

  @HiveField(6)
  Vehicle vehicle;

  Request({
    required this.to,
    required this.from,
    required this.client,
    required this.status,
    required this.message,
    required this.vehicle,
    required this.locations,
  });

  factory Request.fromJson(json) => _$RequestFromJson(json);
  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
