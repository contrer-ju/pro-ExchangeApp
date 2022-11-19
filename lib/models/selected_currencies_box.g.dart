// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_currencies_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectedCurrenciesBoxAdapter extends TypeAdapter<SelectedCurrenciesBox> {
  @override
  final int typeId = 0;

  @override
  SelectedCurrenciesBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectedCurrenciesBox(
      imageID: fields[0] as String,
      currencyName: fields[1] as String,
      currencyISOCode: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SelectedCurrenciesBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imageID)
      ..writeByte(1)
      ..write(obj.currencyName)
      ..writeByte(2)
      ..write(obj.currencyISOCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedCurrenciesBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
