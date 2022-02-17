// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleAdapter extends TypeAdapter<Vehicle> {
  @override
  final int typeId = 2;

  @override
  Vehicle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vehicle(
      id: fields[0] as String,
      make: fields[1] as String,
      user: fields[6] as User,
      model: fields[2] as String,
      plate: fields[3] as String,
      color: fields[4] as String,
      images: (fields[8] as List).cast<String>(),
      available: fields[7] as bool,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Vehicle obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.make)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.plate)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.user)
      ..writeByte(7)
      ..write(obj.available)
      ..writeByte(8)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      id: json['_id'] as String,
      make: json['make'] as String,
      user: User.fromJson(json['user']),
      model: json['model'] as String,
      plate: json['plate'] as String,
      color: json['color'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      available: json['available'] as bool,
      description: json['description'] as String,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      '_id': instance.id,
      'make': instance.make,
      'model': instance.model,
      'plate': instance.plate,
      'color': instance.color,
      'description': instance.description,
      'user': instance.user,
      'available': instance.available,
      'images': instance.images,
    };
