import 'package:crs/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.model.g.dart';

@JsonSerializable()
@HiveType(typeId: Constants.LOCATION_TYPE)
class Location extends HiveObject {
  List<double> coordinates;

  Location({
    required this.coordinates,
  });

  factory Location.fromJson(json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
