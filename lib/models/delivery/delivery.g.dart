// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryAdapter extends TypeAdapter<Delivery> {
  @override
  final int typeId = 1;

  @override
  Delivery read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Delivery(
      id: fields[0] as int,
      code: fields[1] as String,
      carNumber: fields[2] as int,
      carType: fields[3] as String,
      transactionType: fields[4] as String,
      status: fields[5] as String,
      userId: fields[6] as int,
      userEmail: fields[7] as String,
      departLat: fields[8] as String,
      departLng: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Delivery obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.carNumber)
      ..writeByte(3)
      ..write(obj.carType)
      ..writeByte(4)
      ..write(obj.transactionType)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.userEmail)
      ..writeByte(8)
      ..write(obj.departLat)
      ..writeByte(9)
      ..write(obj.departLng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
