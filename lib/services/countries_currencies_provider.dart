import 'package:the_exchange_app/constants/countries_currencies.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:the_exchange_app/models/currencies_box.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class CountriesCurrenciesProvider extends ChangeNotifier {
  bool isWaiting = true;
  final boxSelectedCurrenciesList =
      Hive.box<SelectedCurrenciesBox>('currenciesListBox');
  bool isFirstLoad = Hive.box('firstLoadBox').get('value') ?? true;
  late List<String> storageImageIDList;
  String countrySearchKeyword = "";
  List<CountryCurrency> countriesCurrenciesList = kCountriesCurrenciesList;
  List<CountryCurrency> countryCurrenciesSearchList = kCountriesCurrenciesList;

  void toggleCheckboxOfCurrency(String toggleCurrencyISOCode) {
    for (int i = 0; i < countriesCurrenciesList.length; i++) {
      if (countriesCurrenciesList[i].currencyISOCode == toggleCurrencyISOCode) {
        countriesCurrenciesList[i].isChecked =
            !countriesCurrenciesList[i].isChecked;
      }
    }
    notifyListeners();
  }

  void clearCurrenciesSelected() {
    for (final item in countriesCurrenciesList) {
      if (item.isChecked) item.isChecked = false;
    }
    notifyListeners();
  }

  void searchKeywordOnCountriesList(currencyKeyword) {
    countryCurrenciesSearchList = countriesCurrenciesList
        .where((item) =>
            item.countryName
                .toLowerCase()
                .contains(currencyKeyword.toLowerCase()) ||
            item.currencyName
                .toLowerCase()
                .contains(currencyKeyword.toLowerCase()) ||
            item.currencyISOCode
                .toLowerCase()
                .contains(currencyKeyword.toLowerCase()))
        .toList();
    countrySearchKeyword = currencyKeyword;
    notifyListeners();
  }

  void clearCountryCurrenciesSearchList() {
    countryCurrenciesSearchList = countriesCurrenciesList;
    countrySearchKeyword = "";
    notifyListeners();
  }

  void loadCountryList() {
    isWaiting = true;
    if (!isFirstLoad) {
      final boxLength = boxSelectedCurrenciesList.length;
      if (boxLength > 0) {
        for (int i = 0; i < boxLength; i++) {
          final storedCurrency = boxSelectedCurrenciesList.getAt(i);
          final indexValue = countriesCurrenciesList.indexWhere(
              (item) => item.countryISOCode == storedCurrency!.imageID);
          if (indexValue != -1) {
            countriesCurrenciesList[indexValue].isChecked = true;
          }
        }
      }
    }
    isWaiting = false;
    notifyListeners();
  }

  void setOnFirstLoad() {
    List countriesOnLoad = ["us", "eu", "ca", "gb"];
    for (int i = 0; i < 4; i++) {
      final indexValue = countriesCurrenciesList
          .indexWhere((item) => item.countryISOCode == countriesOnLoad[i]);
      if (indexValue != -1) {
        countriesCurrenciesList[indexValue].isChecked = true;
      }
    }
    notifyListeners();
  }
}
