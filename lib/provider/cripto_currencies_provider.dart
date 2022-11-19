import 'package:the_exchange_app/constants/cripto_currencies.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:the_exchange_app/models/selected_currencies_box.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class CriptoCurrenciesProvider extends ChangeNotifier {
  bool isWaiting = true;
  final boxSelectedCurrenciesList =
      Hive.box<SelectedCurrenciesBox>('selectedCurrenciesBox');
  late List<String> storageImageIDList;
  List<CriptoCurrency> criptoCurrenciesList = kCriptoCurrenciesList;
  List<CriptoCurrency> criptoCurrenciesSearchList = kCriptoCurrenciesList;

  void toggleCheckboxOfCurrency(String toggleCurrencyISOCode) {
    final indexValue = criptoCurrenciesList
        .indexWhere((item) => item.currencyISOCode == toggleCurrencyISOCode);

    if (indexValue != -1) {
      criptoCurrenciesList[indexValue].isChecked =
          !criptoCurrenciesList[indexValue].isChecked;
      notifyListeners();
    }
  }

  void clearCurrenciesSelected() {
    for (final item in criptoCurrenciesList) {
      if (item.isChecked) item.isChecked = false;
    }
    notifyListeners();
  }

  void searchKeywordOnCriptoList(criptoKeyword) {
    criptoCurrenciesSearchList = criptoCurrenciesList
        .where((item) =>
            item.currencyName
                .toLowerCase()
                .contains(criptoKeyword.toLowerCase()) ||
            item.currencyISOCode
                .toLowerCase()
                .contains(criptoKeyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void clearCriptoCurrenciesSearchList() {
    criptoCurrenciesSearchList = criptoCurrenciesList;
    notifyListeners();
  }

  void loadCriptoList() {
    isWaiting = true;
    final boxLength = boxSelectedCurrenciesList.length;
    if (boxLength > 0) {
      for (int i = 0; i < boxLength; i++) {
        final storedCurrency = boxSelectedCurrenciesList.getAt(i);
        final indexValue = criptoCurrenciesList.indexWhere(
            (item) => item.currencyISOCode == storedCurrency!.imageID);
        if (indexValue != -1) {
          criptoCurrenciesList[indexValue].isChecked = true;
        }
      }
    }
    isWaiting = false;
    notifyListeners();
  }
}
