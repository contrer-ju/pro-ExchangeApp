import 'package:hive/hive.dart';
part 'currencies_box.g.dart';

@HiveType(typeId: 0)
class SelectedCurrenciesBox extends HiveObject {
  @HiveField(0)
  final String imageID;
  @HiveField(1)
  final String currencyName;
  @HiveField(2)
  final String currencyISOCode;
  @HiveField(3)
  final double currencyRate;

  SelectedCurrenciesBox(
      {required this.imageID,
      required this.currencyName,
      required this.currencyISOCode,
      required this.currencyRate});
}
