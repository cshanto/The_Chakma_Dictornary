// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DictionaryEntryAdapter extends TypeAdapter<DictionaryEntry> {
  @override
  final int typeId = 0;

  @override
  DictionaryEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DictionaryEntry(
      word: fields[0] as String,
      definition: fields[1] as String,
      example: fields[2] as String,
      chakma1: fields[4] as String,
      chakma2: fields[5] as String,
      chakma1Example: fields[6] as String?,
      chakma2Example: fields[7] as String?,
      createdAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DictionaryEntry obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.definition)
      ..writeByte(2)
      ..write(obj.example)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.chakma1)
      ..writeByte(5)
      ..write(obj.chakma2)
      ..writeByte(6)
      ..write(obj.chakma1Example)
      ..writeByte(7)
      ..write(obj.chakma2Example);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DictionaryEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
