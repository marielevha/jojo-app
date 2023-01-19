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
      routeNumber: fields[23] as int,
      carNumber: fields[2] as int,
      carType: fields[3] as String,
      transactionType: fields[4] as String,
      status: fields[5] as String,
      userId: fields[6] as int,
      userEmail: fields[7] as String,
      departLat: fields[8] as String,
      departLng: fields[9] as String,
      departCity: fields[10] as String,
      departDate: fields[11] as String,
      departHour: fields[12] as String,
      destinationLat: fields[13] as String,
      destinationLng: fields[14] as String,
      destinationCity: fields[15] as String,
      destinationDate: fields[16] as String,
      destinationHour: fields[17] as String,
      stopLat: fields[18] as String,
      stopLng: fields[19] as String,
      stopCity: fields[20] as String,
      stopDate: fields[21] as String,
      stopHour: fields[22] as String,
      contactName: fields[24] as String,
      contactPhone: fields[25] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Delivery obj) {
    writer
      ..writeByte(26)
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
      ..write(obj.departLng)
      ..writeByte(10)
      ..write(obj.departCity)
      ..writeByte(11)
      ..write(obj.departDate)
      ..writeByte(12)
      ..write(obj.departHour)
      ..writeByte(13)
      ..write(obj.destinationLat)
      ..writeByte(14)
      ..write(obj.destinationLng)
      ..writeByte(15)
      ..write(obj.destinationCity)
      ..writeByte(16)
      ..write(obj.destinationDate)
      ..writeByte(17)
      ..write(obj.destinationHour)
      ..writeByte(18)
      ..write(obj.stopLat)
      ..writeByte(19)
      ..write(obj.stopLng)
      ..writeByte(20)
      ..write(obj.stopCity)
      ..writeByte(21)
      ..write(obj.stopDate)
      ..writeByte(22)
      ..write(obj.stopHour)
      ..writeByte(23)
      ..write(obj.routeNumber)
      ..writeByte(24)
      ..write(obj.contactName)
      ..writeByte(25)
      ..write(obj.contactPhone);
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
