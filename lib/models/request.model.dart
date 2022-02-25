import 'package:crs/models/location.model.dart';
import 'package:crs/models/user.model.dart';
import 'package:crs/models/vehicle.model.dart';
import 'package:crs/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.model.g.dart';

@JsonSerializable()
@HiveType(typeId: Constants.REQUEST_TYPE)
class Request extends HiveObject {
  @HiveField(0)
  @JsonKey(name: '_id')
  String id;

  @HiveField(1)
  DateTime to;

  @HiveField(2)
  DateTime from;

  @HiveField(3)
  List<Location> locations;

  @HiveField(4)
  String message;

  @HiveField(5)
  String status;

  @HiveField(6)
  User client;

  @HiveField(7)
  Vehicle vehicle;

  @HiveField(8)
  DateTime start;

  @HiveField(9)
  DateTime end;

  Request({
    required this.id,
    required this.to,
    required this.end,
    required this.from,
    required this.start,
    required this.client,
    required this.status,
    required this.message,
    required this.vehicle,
    required this.locations,
  });

  String getRange() {
    var end = DateFormat("hh:MM a").format(to);
    var start = DateFormat("hh:MM a").format(from);
    return '$start to $end';
  }

  String getCost() {
    var zoneDiff = const Duration(hours: 2); // Due to mongoDB
    var diff = DateTime.now().difference(start.subtract(zoneDiff));
    return NumberFormat().format((diff.inHours * vehicle.rate).round());
  }

  String getTotalCost() {
    print("start is $start and end is $end");
    var diff = end.difference(start).inHours;
    return NumberFormat().format((diff * vehicle.rate).round());
  }

  factory Request.fromJson(json) => _$RequestFromJson(json);
  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
