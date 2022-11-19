import 'package:the_exchange_app/constants/reference_currencies.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:flutter/foundation.dart';

class ReferenceCurrenciesProvider extends ChangeNotifier {
  List<ReferenceCurrency> referencesCurrenciesList = kReferenceCurrenciesList;

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
}
