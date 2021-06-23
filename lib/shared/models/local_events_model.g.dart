// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_events_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalEventAdapter extends TypeAdapter<LocalEvent> {
  @override
  final int typeId = 0;

  @override
  LocalEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalEvent(
      fields[0] as int?,
      fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalEvent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.eventId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
