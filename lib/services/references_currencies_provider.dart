import 'package:hive/hive.dart';
import 'package:the_exchange_app/constants/reference_currencies.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:flutter/foundation.dart';
import 'package:the_exchange_app/models/currencies_box.dart';

class ReferenceCurrenciesProvider extends ChangeNotifier {
  bool isWaiting = true;
  final boxSelectedCurrenciesList =
      Hive.box<SelectedCurrenciesBox>('currenciesListBox');
  bool isFirstLoad = Hive.box('firstLoadBox').get('value') ?? true;
  late List<String> storageImageIDList;
  String referenceSearchKeyword = "";
  List<ReferenceCurrency> referencesCurrenciesList = kReferenceCurrenciesList;
  List<ReferenceCurrency> referencesCurrenciesSearchList =
      kReferenceCurrenciesList;

  void toggleCheckboxOfCurrency(String toggleCurrencyISOCode) {
    final indexValue = referencesCurrenciesList
        .indexWhere((item) => item.referenceID == toggleCurrencyISOCode);

    if (indexValue != -1) {
      referencesCurrenciesList[indexValue].isChecked =
          !referencesCurrenciesList[indexValue].isChecked;
      notifyListeners();
    }
  }

  void clearCurrenciesSelected() {
    for (final item in referencesCurrenciesList) {
      if (item.isChecked) item.isChecked = false;
    }
    notifyListeners();
  }

  void searchKeywordOnReferenceList(referenceKeyword) {
    referencesCurrenciesSearchList = referencesCurrenciesList
        .where((item) =>
            item.referenceName
                .toLowerCase()
                .contains(referenceKeyword.toLowerCase()) ||
            item.nombreReferencia
                .toLowerCase()
                .contains(referenceKeyword.toLowerCase()) ||
            item.referenceID
                .toLowerCase()
                .contains(referenceKeyword.toLowerCase()))
        .toList();
    referenceSearchKeyword = referenceKeyword;
    notifyListeners();
  }

  void clearReferenceCurrenciesSearchList() {
    referencesCurrenciesSearchList = referencesCurrenciesList;
    referenceSearchKeyword = "";
    notifyListeners();
  }

  void loadReferenceList() {
    isWaiting = true;
    if (!isFirstLoad) {
      final boxLength = boxSelectedCurrenciesList.length;
      if (boxLength > 0) {
        for (int i = 0; i < boxLength; i++) {
          final storedCurrency = boxSelectedCurrenciesList.getAt(i);
          final indexValue = referencesCurrenciesList.indexWhere(
              (item) => item.referenceID == storedCurrency!.imageID);
          if (indexValue != -1) {
            referencesCurrenciesList[indexValue].isChecked = true;
          }
        }
      }
    }
    isWaiting = false;
    notifyListeners();
  }
}
