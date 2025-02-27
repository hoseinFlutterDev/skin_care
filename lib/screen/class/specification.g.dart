// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpecificationAdapter extends TypeAdapter<Specification> {
  @override
  final int typeId = 0;

  @override
  Specification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Specification(
      address: fields[9] as String,
      history: fields[8] as String,
      id: fields[1] as int,
      imagePath: fields[2] as String?,
      name: fields[3] as String,
      famely: fields[4] as String,
      nation: fields[5] as String,
      number: fields[6] as String,
      age: fields[7] as String,
      imagePaths: (fields[10] as List).cast<String>(),
      visits: (fields[11] as HiveList).castHiveList(),
      futureAppointment: fields[12] as Reminder?,
    );
  }

  @override
  void write(BinaryWriter writer, Specification obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.famely)
      ..writeByte(5)
      ..write(obj.nation)
      ..writeByte(6)
      ..write(obj.number)
      ..writeByte(7)
      ..write(obj.age)
      ..writeByte(8)
      ..write(obj.history)
      ..writeByte(9)
      ..write(obj.address)
      ..writeByte(10)
      ..write(obj.imagePaths)
      ..writeByte(11)
      ..write(obj.visits)
      ..writeByte(12)
      ..write(obj.futureAppointment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
