// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currencies_box.dart';

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
      nombreMoneda: fields[2] as String,
      currencyISOCode: fields[3] as String,
      currencyRate: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SelectedCurrenciesBox obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imageID)
      ..writeByte(1)
      ..write(obj.currencyName)
      ..writeByte(2)
      ..write(obj.nombreMoneda)
      ..writeByte(3)
      ..write(obj.currencyISOCode)
      ..writeByte(4)
      ..write(obj.currencyRate);
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
