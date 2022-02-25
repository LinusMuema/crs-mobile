// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestAdapter extends TypeAdapter<Request> {
  @override
  final int typeId = 1;

  @override
  Request read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Request(
      to: fields[0] as DateTime,
      from: fields[1] as DateTime,
      client: fields[5] as User,
      status: fields[4] as String,
      message: fields[3] as String,
      vehicle: fields[6] as Vehicle,
      locations: (fields[2] as List).cast<Location>(),
    );
  }

  @override
  void write(BinaryWriter writer, Request obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.to)
      ..writeByte(1)
      ..write(obj.from)
      ..writeByte(2)
      ..write(obj.locations)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.client)
      ..writeByte(6)
      ..write(obj.vehicle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      to: DateTime.parse(json['to'] as String),
      from: DateTime.parse(json['from'] as String),
      client: User.fromJson(json['client']),
      status: json['status'] as String,
      message: json['message'] as String,
      vehicle: Vehicle.fromJson(json['vehicle']),
      locations: (json['locations'] as List<dynamic>)
          .map((e) => Location.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'to': instance.to.toIso8601String(),
      'from': instance.from.toIso8601String(),
      'locations': instance.locations,
      'message': instance.message,
      'status': instance.status,
      'client': instance.client,
      'vehicle': instance.vehicle,
    };
