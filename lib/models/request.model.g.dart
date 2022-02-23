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
      id: fields[0] as String,
      to: fields[1] as DateTime,
      end: fields[9] as DateTime,
      from: fields[2] as DateTime,
      start: fields[8] as DateTime,
      client: fields[6] as User,
      status: fields[5] as String,
      message: fields[4] as String,
      vehicle: fields[7] as Vehicle,
      locations: (fields[3] as List).cast<Location>(),
    );
  }

  @override
  void write(BinaryWriter writer, Request obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.to)
      ..writeByte(2)
      ..write(obj.from)
      ..writeByte(3)
      ..write(obj.locations)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.client)
      ..writeByte(7)
      ..write(obj.vehicle)
      ..writeByte(8)
      ..write(obj.start)
      ..writeByte(9)
      ..write(obj.end);
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
      id: json['_id'] as String,
      to: DateTime.parse(json['to'] as String),
      end: DateTime.parse(json['end'] as String),
      from: DateTime.parse(json['from'] as String),
      start: DateTime.parse(json['start'] as String),
      client: User.fromJson(json['client']),
      status: json['status'] as String,
      message: json['message'] as String,
      vehicle: Vehicle.fromJson(json['vehicle']),
      locations: (json['locations'] as List<dynamic>)
          .map((e) => Location.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      '_id': instance.id,
      'to': instance.to.toIso8601String(),
      'from': instance.from.toIso8601String(),
      'locations': instance.locations,
      'message': instance.message,
      'status': instance.status,
      'client': instance.client,
      'vehicle': instance.vehicle,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };
