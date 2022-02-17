import 'package:crs/models/user.model.dart';
import 'package:crs/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle.model.g.dart';

@JsonSerializable()
@HiveType(typeId: Constants.VEHICLE_TYPE)
class Vehicle extends HiveObject {
  @HiveField(0)
  @JsonKey(name: '_id')
  String id;

  @HiveField(1)
  String make;

  @HiveField(2)
  String model;

  @HiveField(3)
  String plate;

  @HiveField(4)
  String color;

  @HiveField(5)
  String description;

  @HiveField(6)
  User user;

  @HiveField(7)
  bool available;

  @HiveField(8)
  List<String> images;

  Vehicle({
    required this.id,
    required this.make,
    required this.user,
    required this.model,
    required this.plate,
    required this.color,
    required this.images,
    required this.available,
    required this.description,
  });

  factory Vehicle.fromJson(json) => _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
