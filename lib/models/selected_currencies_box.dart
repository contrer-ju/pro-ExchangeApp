import 'package:hive/hive.dart';
part 'selected_currencies_box.g.dart';

@HiveType(typeId: 0)
class SelectedCurrenciesBox extends HiveObject {
  @HiveField(0)
  final String imageID;
  @HiveField(1)
  final String currencyName;
  @HiveField(2)
  final String currencyISOCode;

  SelectedCurrenciesBox({
    required this.imageID,
    required this.currencyName,
    required this.currencyISOCode,
  });
}
