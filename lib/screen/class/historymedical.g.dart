// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historymedical.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryMedicalAdapter extends TypeAdapter<HistoryMedical> {
  @override
  final int typeId = 1;

  @override
  HistoryMedical read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryMedical(
      imageVisit: fields[5] as String?,
      id: fields[1] as int,
      historyMedical: fields[2] as String,
      visitDate: fields[3] as String,
      visitTime: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryMedical obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.historyMedical)
      ..writeByte(3)
      ..write(obj.visitDate)
      ..writeByte(4)
      ..write(obj.visitTime)
      ..writeByte(5)
      ..write(obj.imageVisit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryMedicalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
