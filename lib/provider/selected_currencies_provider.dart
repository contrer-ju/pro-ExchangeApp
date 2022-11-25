import 'package:the_exchange_app/models/currencies.dart';
import 'package:the_exchange_app/models/currencies_box.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class SelectedCurrenciesProvider extends ChangeNotifier {
  bool isWaiting = true;
  final boxSelectedCurrenciesList =
      Hive.box<SelectedCurrenciesBox>('selectedCurrenciesBox');
  double baseSelectedCurrencyAmount = 0;
  SelectedCurrencies baseSelectedCurrency = SelectedCurrencies(
    imageID: '',
    currencyName: '',
    currencyISOCode: '',
  );
  List<SelectedCurrencies> selectedCurrenciesList = [];
  List<SelectedCurrencies> selectedToDeleteCurrenciesList = [];
  List<SelectedCurrencies> searchedToDeleteCurrenciesList = [];

  void setBaseSelectedCurrencyAmount(double enteredAmount) {
    baseSelectedCurrencyAmount = enteredAmount;
    notifyListeners();
  }

  void addCurrencyToList(
    String selectedImageID,
    String selectedCurrencyName,
    String selectedCurrencyISOCode,
  ) {
    late String imageID;
    switch (selectedCurrencyISOCode) {
      case 'aud':
        imageID = 'au';
        break;
      case 'xof':
        imageID = 'xof';
        break;
      case 'xaf':
        imageID = 'xaf';
        break;
      case 'ang':
        imageID = 'ang';
        break;
      case 'dkk':
        imageID = 'dk';
        break;
      case 'xcd':
        imageID = 'xcd';
        break;
      case 'eur':
        imageID = 'eu';
        break;
      case 'xpf':
        imageID = 'xpf';
        break;
      case 'mad':
        imageID = 'ma';
        break;
      case 'nok':
        imageID = 'no';
        break;
      case 'chf':
        imageID = 'ch';
        break;
      case 'gbp':
        imageID = 'gb';
        break;
      case 'usd':
        imageID = 'us';
        break;
      default:
        imageID = selectedImageID;
    }
    SelectedCurrencies currencyToAdd = SelectedCurrencies(
      imageID: imageID,
      currencyName: selectedCurrencyName,
      currencyISOCode: selectedCurrencyISOCode,
    );
    if (selectedCurrenciesList.isEmpty &&
        baseSelectedCurrency.currencyName == '') {
      baseSelectedCurrency = currencyToAdd;
      selectedToDeleteCurrenciesList.add(currencyToAdd);
      searchedToDeleteCurrenciesList.add(currencyToAdd);
    } else {
      selectedCurrenciesList.add(currencyToAdd);
      selectedToDeleteCurrenciesList.add(currencyToAdd);
      searchedToDeleteCurrenciesList.add(currencyToAdd);
    }
    notifyListeners();
  }

  void deletedCurrencyFromList(String selectedCurrencyISOCode) {
    bool flag = true;
    if (baseSelectedCurrency.currencyISOCode == selectedCurrencyISOCode &&
        selectedCurrenciesList.isEmpty) {
      baseSelectedCurrency.imageID = "";
      baseSelectedCurrency.currencyName = "";
      baseSelectedCurrency.currencyISOCode = "";
      selectedToDeleteCurrenciesList = [];
      searchedToDeleteCurrenciesList = [];
      flag = false;
    }
    if (baseSelectedCurrency.currencyISOCode == selectedCurrencyISOCode &&
        selectedCurrenciesList.isNotEmpty &&
        flag) {
      baseSelectedCurrency.imageID = selectedCurrenciesList[0].imageID;
      baseSelectedCurrency.currencyName =
          selectedCurrenciesList[0].currencyName;
      baseSelectedCurrency.currencyISOCode =
          selectedCurrenciesList[0].currencyISOCode;
      selectedCurrenciesList.removeAt(0);
      selectedToDeleteCurrenciesList.removeAt(0);
      searchedToDeleteCurrenciesList.removeAt(0);
      flag = false;
    }
    if (baseSelectedCurrency.currencyISOCode != selectedCurrencyISOCode &&
        selectedCurrenciesList.isNotEmpty &&
        flag) {
      selectedCurrenciesList.removeWhere(
          (item) => item.currencyISOCode == selectedCurrencyISOCode);
      selectedToDeleteCurrenciesList.removeWhere(
          (item) => item.currencyISOCode == selectedCurrencyISOCode);
      searchedToDeleteCurrenciesList.removeWhere(
          (item) => item.currencyISOCode == selectedCurrencyISOCode);
    }
    notifyListeners();
  }

  void emptyCurrenciesList() {
    baseSelectedCurrency.imageID = "";
    baseSelectedCurrency.currencyName = "";
    baseSelectedCurrency.currencyISOCode = "";
    selectedCurrenciesList = [];
    selectedToDeleteCurrenciesList = [];
    searchedToDeleteCurrenciesList = [];
    notifyListeners();
  }

  void setBaseSelectedCurrency(String currencyID, double enteredAmount) {
    baseSelectedCurrencyAmount = enteredAmount;
    SelectedCurrencies baseSelectedCurrencyToMove = SelectedCurrencies(
      imageID: baseSelectedCurrency.imageID,
      currencyName: baseSelectedCurrency.currencyName,
      currencyISOCode: baseSelectedCurrency.currencyISOCode,
    );
    selectedCurrenciesList.add(baseSelectedCurrencyToMove);
    selectedToDeleteCurrenciesList.removeAt(0);
    selectedToDeleteCurrenciesList.add(baseSelectedCurrencyToMove);
    searchedToDeleteCurrenciesList.removeAt(0);
    searchedToDeleteCurrenciesList.add(baseSelectedCurrencyToMove);

    int currencyIndex =
        selectedCurrenciesList.indexWhere((item) => item.imageID == currencyID);

    baseSelectedCurrency.imageID =
        selectedCurrenciesList[currencyIndex].imageID;
    baseSelectedCurrency.currencyName =
        selectedCurrenciesList[currencyIndex].currencyName;
    baseSelectedCurrency.currencyISOCode =
        selectedCurrenciesList[currencyIndex].currencyISOCode;

    selectedCurrenciesList.removeAt(currencyIndex);
    selectedToDeleteCurrenciesList
        .removeWhere((item) => item.imageID == currencyID);
    selectedToDeleteCurrenciesList.insert(0, baseSelectedCurrency);
    searchedToDeleteCurrenciesList
        .removeWhere((item) => item.imageID == currencyID);
    searchedToDeleteCurrenciesList.insert(0, baseSelectedCurrency);
    notifyListeners();
  }

  void onReorderSelectedCurrenciesList(
      List<SelectedCurrencies> reorderCurrenciesList) {
    selectedToDeleteCurrenciesList =
        List<SelectedCurrencies>.from(reorderCurrenciesList);
    searchedToDeleteCurrenciesList =
        List<SelectedCurrencies>.from(reorderCurrenciesList);
    selectedToDeleteCurrenciesList.insert(0, baseSelectedCurrency);
    searchedToDeleteCurrenciesList.insert(0, baseSelectedCurrency);
    notifyListeners();
  }

  void searchKeywordOnSelectedList(currencyKeyword) {
    searchedToDeleteCurrenciesList = selectedToDeleteCurrenciesList
        .where((item) =>
            item.currencyName
                .toLowerCase()
                .contains(currencyKeyword.toLowerCase()) ||
            item.currencyISOCode
                .toLowerCase()
                .contains(currencyKeyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void clearSelectedCurrenciesSearchList() {
    List<SelectedCurrencies> selectedToDeleteCurrenciesListCopy =
        List<SelectedCurrencies>.from(selectedToDeleteCurrenciesList);
    searchedToDeleteCurrenciesList = selectedToDeleteCurrenciesListCopy;
    notifyListeners();
  }

  void loadCurrenciesList() {
    isWaiting = true;
    final boxSelectedCurrenciesListLength = boxSelectedCurrenciesList.length;

    if (boxSelectedCurrenciesListLength > 0) {
      for (int i = 0; i < boxSelectedCurrenciesListLength; i++) {
        final storedCurrency = boxSelectedCurrenciesList.getAt(i);
        SelectedCurrencies currencyToAdd = SelectedCurrencies(
          imageID: storedCurrency!.imageID,
          currencyName: storedCurrency.currencyName,
          currencyISOCode: storedCurrency.currencyISOCode,
        );
        if (selectedCurrenciesList.isEmpty &&
            baseSelectedCurrency.currencyName == '') {
          baseSelectedCurrency = currencyToAdd;
          selectedToDeleteCurrenciesList.add(currencyToAdd);
          searchedToDeleteCurrenciesList.add(currencyToAdd);
        } else {
          selectedCurrenciesList.add(currencyToAdd);
          selectedToDeleteCurrenciesList.add(currencyToAdd);
          searchedToDeleteCurrenciesList.add(currencyToAdd);
        }
      }
    }
    isWaiting = false;
    notifyListeners();
  }

  void saveCurrenciesList() {
    if (baseSelectedCurrency.currencyName == '' &&
        selectedCurrenciesList.isEmpty) {
      boxSelectedCurrenciesList.clear();
    }

    if (baseSelectedCurrency.currencyName != '' &&
        selectedCurrenciesList.isEmpty) {
      boxSelectedCurrenciesList.clear();
      boxSelectedCurrenciesList.add(SelectedCurrenciesBox(
        imageID: baseSelectedCurrency.imageID,
        currencyName: baseSelectedCurrency.currencyName,
        currencyISOCode: baseSelectedCurrency.currencyISOCode,
      ));
    }

    if (baseSelectedCurrency.currencyName != '' &&
        selectedCurrenciesList.isNotEmpty) {
      boxSelectedCurrenciesList.clear();
      boxSelectedCurrenciesList.add(SelectedCurrenciesBox(
        imageID: baseSelectedCurrency.imageID,
        currencyName: baseSelectedCurrency.currencyName,
        currencyISOCode: baseSelectedCurrency.currencyISOCode,
      ));
      for (int i = 0; i < selectedCurrenciesList.length; i++) {
        boxSelectedCurrenciesList.add(SelectedCurrenciesBox(
          imageID: selectedCurrenciesList[i].imageID,
          currencyName: selectedCurrenciesList[i].currencyName,
          currencyISOCode: selectedCurrenciesList[i].currencyISOCode,
        ));
      }
    }
  }
}
