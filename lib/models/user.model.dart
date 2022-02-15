import 'package:crs/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
@HiveType(typeId: Constants.USER_TYPE)
class User {
  @HiveField(0)
  @JsonKey(name: '_id')
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String avatar;

  User({
    required this.id,
    required this.phone,
    required this.avatar,
    required this.username,
  });

  factory User.fromJson(json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
