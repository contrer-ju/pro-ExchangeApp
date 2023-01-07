import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_exchange_app/constants/countries_currencies.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:the_exchange_app/models/currencies_box.dart';
import 'package:hive/hive.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedCurrenciesProvider extends ChangeNotifier {
  bool isWaiting = true;
  bool isUpdating = false;
  final boxSelectedCurrenciesList =
      Hive.box<SelectedCurrenciesBox>('currenciesListBox');
  bool isFirstLoad = Hive.box('firstLoadBox').get('value') ?? true;
  double baseSelectedCurrencyAmount =
      Hive.box('baseSelectedAmount').get('value') ?? 0;
  List currenciesRatesList = [];
  SelectedCurrencies baseSelectedCurrency = SelectedCurrencies(
    imageID: '',
    currencyName: '',
    nombreMoneda: '',
    currencyISOCode: '',
    currencyRate: 1,
    wasUpdated: false,
    wasRead: false,
  );
  List<SelectedCurrencies> selectedCurrenciesList = [];
  List<SelectedCurrencies> selectedToDeleteCurrenciesList = [];
  List<SelectedCurrencies> searchedToDeleteCurrenciesList = [];
  String selectedSearchKeyword = "";
  int lastUpdateTime = Hive.box('lastUpdateBox').get('value') ?? 0;

  Future<bool> getCurrenciesRates() async {
    List currenciesRatesData = [];
    CollectionReference ratesCollection =
        FirebaseFirestore.instance.collection("currenciesRates");
    QuerySnapshot rates = await ratesCollection.get();

    if (rates.docs.isNotEmpty) {
      for (var doc in rates.docs) {
        currenciesRatesData.add(doc.data());
      }
      if (currenciesRatesData.isNotEmpty) {
        currenciesRatesList = [];
        for (int i = 0; i < currenciesRatesData.length; i++) {
          CurrenciesRates currenciesRateValue = CurrenciesRates(
              currencyISOCode: currenciesRatesData[i]['currencyISOCode'],
              currencyRate: currenciesRatesData[i]['currencyRate'] is int
                  ? currenciesRatesData[i]['currencyRate'].toDouble()
                  : currenciesRatesData[i]['currencyRate'] is String
                      ? double.parse(currenciesRatesData[i]['currencyRate'])
                      : currenciesRatesData[i]['currencyRate']);
          currenciesRatesList.add(currenciesRateValue);
        }
        lastUpdateTime = DateTime.now().millisecondsSinceEpoch;
        Hive.box('lastUpdateBox').put('value', lastUpdateTime);
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> connectionTest() async {
    var pingResult = await pingFunction();
    if (pingResult.toString().contains("received:0") ||
        pingResult.toString().contains("PingError")) {
      return false;
    } else {
      return true;
    }
  }

  Future<PingData> pingFunction() async {
    final ping = Ping('google.com', count: 5);
    return await ping.stream.last;
  }

  void setBaseSelectedCurrencyAmount(double enteredAmount) {
    baseSelectedCurrencyAmount = enteredAmount;
    notifyListeners();
  }

  void addCurrencyToList(
    String selectedImageID,
    String selectedCurrencyName,
    String selectedNombreMoneda,
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
    double selectedCurrencyRate = 0;

    if (currenciesRatesList.isNotEmpty) {
      int selectedCurrencyIndex = currenciesRatesList.indexWhere(
          (item) => item.currencyISOCode == selectedCurrencyISOCode);
      selectedCurrencyRate =
          currenciesRatesList[selectedCurrencyIndex].currencyRate;
    }
    SelectedCurrencies currencyToAdd = SelectedCurrencies(
      imageID: imageID,
      currencyName: selectedCurrencyName,
      nombreMoneda: selectedNombreMoneda,
      currencyISOCode: selectedCurrencyISOCode,
      currencyRate: selectedCurrencyRate,
      wasUpdated: selectedCurrencyRate != 0 ? true : false,
      wasRead: false,
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
      baseSelectedCurrencyAmount = 0;
      baseSelectedCurrency.imageID = "";
      baseSelectedCurrency.currencyName = "";
      baseSelectedCurrency.nombreMoneda = "";
      baseSelectedCurrency.currencyISOCode = "";
      baseSelectedCurrency.currencyRate = 1;
      baseSelectedCurrency.wasUpdated = false;
      baseSelectedCurrency.wasRead = false;
      selectedToDeleteCurrenciesList = [];
      searchedToDeleteCurrenciesList = [];
      flag = false;
    }
    if (baseSelectedCurrency.currencyISOCode == selectedCurrencyISOCode &&
        selectedCurrenciesList.isNotEmpty &&
        flag) {
      baseSelectedCurrencyAmount =
          baseSelectedCurrencyAmount * selectedCurrenciesList[0].currencyRate;
      baseSelectedCurrency.imageID = selectedCurrenciesList[0].imageID;
      baseSelectedCurrency.currencyName =
          selectedCurrenciesList[0].currencyName;
      baseSelectedCurrency.nombreMoneda =
          selectedCurrenciesList[0].nombreMoneda;
      baseSelectedCurrency.currencyISOCode =
          selectedCurrenciesList[0].currencyISOCode;
      baseSelectedCurrency.currencyRate =
          selectedCurrenciesList[0].currencyRate;
      baseSelectedCurrency.wasUpdated = selectedCurrenciesList[0].wasUpdated;
      baseSelectedCurrency.wasRead = selectedCurrenciesList[0].wasRead;
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
    baseSelectedCurrency.nombreMoneda = "";
    baseSelectedCurrency.currencyISOCode = "";
    baseSelectedCurrency.currencyRate = 1;
    baseSelectedCurrency.wasUpdated = false;
    baseSelectedCurrency.wasRead = false;
    selectedCurrenciesList = [];
    selectedToDeleteCurrenciesList = [];
    searchedToDeleteCurrenciesList = [];
    baseSelectedCurrencyAmount = 0;
    notifyListeners();
  }

  void setBaseSelectedCurrency(String currencyID, double enteredAmount) {
    baseSelectedCurrencyAmount = enteredAmount;
    SelectedCurrencies baseSelectedCurrencyToMove = SelectedCurrencies(
      imageID: baseSelectedCurrency.imageID,
      currencyName: baseSelectedCurrency.currencyName,
      nombreMoneda: baseSelectedCurrency.nombreMoneda,
      currencyISOCode: baseSelectedCurrency.currencyISOCode,
      currencyRate: baseSelectedCurrency.currencyRate,
      wasUpdated: baseSelectedCurrency.wasUpdated,
      wasRead: baseSelectedCurrency.wasRead,
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
    baseSelectedCurrency.nombreMoneda =
        selectedCurrenciesList[currencyIndex].nombreMoneda;
    baseSelectedCurrency.currencyISOCode =
        selectedCurrenciesList[currencyIndex].currencyISOCode;
    baseSelectedCurrency.currencyRate =
        selectedCurrenciesList[currencyIndex].currencyRate;
    baseSelectedCurrency.wasUpdated =
        selectedCurrenciesList[currencyIndex].wasUpdated;
    baseSelectedCurrency.wasRead =
        selectedCurrenciesList[currencyIndex].wasRead;

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
            item.nombreMoneda
                .toLowerCase()
                .contains(currencyKeyword.toLowerCase()) ||
            item.currencyISOCode
                .toLowerCase()
                .contains(currencyKeyword.toLowerCase()))
        .toList();
    selectedSearchKeyword = currencyKeyword;
    notifyListeners();
  }

  void clearSelectedCurrenciesSearchList() {
    List<SelectedCurrencies> selectedToDeleteCurrenciesListCopy =
        List<SelectedCurrencies>.from(selectedToDeleteCurrenciesList);
    searchedToDeleteCurrenciesList = selectedToDeleteCurrenciesListCopy;
    selectedSearchKeyword = '';
    notifyListeners();
  }

  Future<void> loadCurrenciesList() async {
    isWaiting = true;
    if (!isFirstLoad) {
      bool currenciesRatesListWasUpdated = false;
      final boxSelectedCurrenciesListLength = boxSelectedCurrenciesList.length;
      bool hasConnection = await connectionTest();
      bool mustUpdateRates = canUpdateRates();
      if (hasConnection && mustUpdateRates) {
        currenciesRatesListWasUpdated = await getCurrenciesRates();
      }

      if (boxSelectedCurrenciesListLength > 0) {
        for (int i = 0; i < boxSelectedCurrenciesListLength; i++) {
          final storedCurrency = boxSelectedCurrenciesList.getAt(i);
          double selectedCurrencyRate = storedCurrency!.currencyRate;
          if (currenciesRatesListWasUpdated) {
            int selectedCurrencyIndex = currenciesRatesList.indexWhere((item) =>
                item.currencyISOCode == storedCurrency.currencyISOCode);
            selectedCurrencyRate =
                currenciesRatesList[selectedCurrencyIndex].currencyRate;
          }

          SelectedCurrencies currencyToAdd = SelectedCurrencies(
            imageID: storedCurrency.imageID,
            currencyName: storedCurrency.currencyName,
            nombreMoneda: storedCurrency.nombreMoneda,
            currencyISOCode: storedCurrency.currencyISOCode,
            currencyRate: selectedCurrencyRate,
            wasUpdated: currenciesRatesListWasUpdated,
            wasRead: !currenciesRatesListWasUpdated,
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
        nombreMoneda: baseSelectedCurrency.nombreMoneda,
        currencyISOCode: baseSelectedCurrency.currencyISOCode,
        currencyRate: baseSelectedCurrency.currencyRate,
      ));
    }

    if (baseSelectedCurrency.currencyName != '' &&
        selectedCurrenciesList.isNotEmpty) {
      boxSelectedCurrenciesList.clear();
      boxSelectedCurrenciesList.add(SelectedCurrenciesBox(
        imageID: baseSelectedCurrency.imageID,
        currencyName: baseSelectedCurrency.currencyName,
        nombreMoneda: baseSelectedCurrency.nombreMoneda,
        currencyISOCode: baseSelectedCurrency.currencyISOCode,
        currencyRate: baseSelectedCurrency.currencyRate,
      ));
      for (int i = 0; i < selectedCurrenciesList.length; i++) {
        boxSelectedCurrenciesList.add(SelectedCurrenciesBox(
          imageID: selectedCurrenciesList[i].imageID,
          currencyName: selectedCurrenciesList[i].currencyName,
          nombreMoneda: selectedCurrenciesList[i].nombreMoneda,
          currencyISOCode: selectedCurrenciesList[i].currencyISOCode,
          currencyRate: selectedCurrenciesList[i].currencyRate,
        ));
      }
    }
  }

  void saveBaseSelectedCurrencyAmount() {
    Hive.box('baseSelectedAmount').put('value', baseSelectedCurrencyAmount);
  }

  void showToastAlert(String message, Color bColor, Color tColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: bColor,
        textColor: tColor,
        fontSize: kToastText);
  }

  void setTrueIsUpdating() {
    if (baseSelectedCurrency.currencyName != '') {
      isUpdating = true;
      notifyListeners();
    }
  }

  Future<void> updateRatesCurrenciesList(
      Color bColor, Color tColor, bool isEnglish) async {
    if (baseSelectedCurrency.currencyName != '') {
      bool listWasUpdated = false;
      bool hasConnection = await connectionTest();
      bool mustUpdateRates = canUpdateRates();
      if (hasConnection && mustUpdateRates) {
        listWasUpdated = await getCurrenciesRates();
      }

      if (listWasUpdated) {
        double baseSelectedCurrencyRate = baseSelectedCurrency.currencyRate;
        if (currenciesRatesList.isNotEmpty) {
          int selectedCurrencyIndex = currenciesRatesList.indexWhere((item) =>
              item.currencyISOCode == baseSelectedCurrency.currencyISOCode);
          baseSelectedCurrencyRate =
              currenciesRatesList[selectedCurrencyIndex].currencyRate;
        }
        baseSelectedCurrency.currencyRate = baseSelectedCurrencyRate;
        baseSelectedCurrency.wasUpdated = listWasUpdated ? true : false;
        for (int i = 0; i < selectedCurrenciesList.length; i++) {
          double selectedCurrenciesListRate =
              selectedCurrenciesList[i].currencyRate;
          if (currenciesRatesList.isNotEmpty) {
            int selectedCurrencyIndex = currenciesRatesList.indexWhere((item) =>
                item.currencyISOCode ==
                selectedCurrenciesList[i].currencyISOCode);
            selectedCurrenciesListRate =
                currenciesRatesList[selectedCurrencyIndex].currencyRate;
          }
          selectedCurrenciesList[i].currencyRate = selectedCurrenciesListRate;
          selectedCurrenciesList[i].wasUpdated = listWasUpdated ? true : false;
        }
      }
      isUpdating = false;
      notifyListeners();
      if (listWasUpdated) {
        showToastAlert(isEnglish ? kMessageUpdateTrue : kEsMessageUpdateTrue,
            bColor, tColor);
      } else {
        if (mustUpdateRates) {
          showToastAlert(isEnglish ? kMessageUpdateFail : kEsMessageUpdateFail,
              bColor, tColor);
        } else {
          showToastAlert(
              isEnglish ? kMessageUpdateRecently : kEsMessageUpdateRecently,
              bColor,
              tColor);
        }
      }
    }
  }

  Future<void> rateApp(Color bColor, Color tColor, bool isEnglish) async {
    isWaiting = true;
    notifyListeners();
    bool hasConnection = await connectionTest();
    if (hasConnection) {
      await launchUrl(Platform.isAndroid ? kPlayStoreURL : kAppsStoreURL,
          mode: LaunchMode.externalApplication);
    } else {
      showToastAlert(
          isEnglish ? kMessageNotConex : kEsMessageNotConex, bColor, tColor);
    }
    isWaiting = false;
    notifyListeners();
  }

  Future<void> readLicense(Color bColor, Color tColor, bool isEnglish) async {
    isWaiting = true;
    notifyListeners();
    bool hasConnection = await connectionTest();
    if (hasConnection) {
      await launchUrl(isEnglish ? kByNcSaLiceneseURL : kEsByNcSaLiceneseURL);
    } else {
      showToastAlert(
          isEnglish ? kMessageNotConex : kEsMessageNotConex, bColor, tColor);
    }
    isWaiting = false;
    notifyListeners();
  }

  void setOnFirstLoad() async {
    if (isFirstLoad) {
      baseSelectedCurrency = SelectedCurrencies(
        imageID: kCountriesCurrenciesList[0].countryISOCode,
        currencyName: kCountriesCurrenciesList[0].currencyName,
        nombreMoneda: kCountriesCurrenciesList[0].moneda,
        currencyISOCode: kCountriesCurrenciesList[0].currencyISOCode,
        currencyRate: 0,
        wasUpdated: false,
        wasRead: false,
      );
      selectedCurrenciesList = [
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[1].countryISOCode,
          currencyName: kCountriesCurrenciesList[1].currencyName,
          nombreMoneda: kCountriesCurrenciesList[1].moneda,
          currencyISOCode: kCountriesCurrenciesList[1].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        ),
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[2].countryISOCode,
          currencyName: kCountriesCurrenciesList[2].currencyName,
          nombreMoneda: kCountriesCurrenciesList[2].moneda,
          currencyISOCode: kCountriesCurrenciesList[2].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        ),
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[3].countryISOCode,
          currencyName: kCountriesCurrenciesList[3].currencyName,
          nombreMoneda: kCountriesCurrenciesList[3].moneda,
          currencyISOCode: kCountriesCurrenciesList[3].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        )
      ];
      selectedToDeleteCurrenciesList = [
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[0].countryISOCode,
          currencyName: kCountriesCurrenciesList[0].currencyName,
          nombreMoneda: kCountriesCurrenciesList[0].moneda,
          currencyISOCode: kCountriesCurrenciesList[0].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        ),
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[1].countryISOCode,
          currencyName: kCountriesCurrenciesList[1].currencyName,
          nombreMoneda: kCountriesCurrenciesList[1].moneda,
          currencyISOCode: kCountriesCurrenciesList[1].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        ),
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[2].countryISOCode,
          currencyName: kCountriesCurrenciesList[2].currencyName,
          nombreMoneda: kCountriesCurrenciesList[2].moneda,
          currencyISOCode: kCountriesCurrenciesList[2].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        ),
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[3].countryISOCode,
          currencyName: kCountriesCurrenciesList[3].currencyName,
          nombreMoneda: kCountriesCurrenciesList[3].moneda,
          currencyISOCode: kCountriesCurrenciesList[3].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        )
      ];
      searchedToDeleteCurrenciesList = [
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[0].countryISOCode,
          currencyName: kCountriesCurrenciesList[0].currencyName,
          nombreMoneda: kCountriesCurrenciesList[0].moneda,
          currencyISOCode: kCountriesCurrenciesList[0].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        ),
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[1].countryISOCode,
          currencyName: kCountriesCurrenciesList[1].currencyName,
          nombreMoneda: kCountriesCurrenciesList[1].moneda,
          currencyISOCode: kCountriesCurrenciesList[1].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        ),
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[2].countryISOCode,
          currencyName: kCountriesCurrenciesList[2].currencyName,
          nombreMoneda: kCountriesCurrenciesList[2].moneda,
          currencyISOCode: kCountriesCurrenciesList[2].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        ),
        SelectedCurrencies(
          imageID: kCountriesCurrenciesList[3].countryISOCode,
          currencyName: kCountriesCurrenciesList[3].currencyName,
          nombreMoneda: kCountriesCurrenciesList[3].moneda,
          currencyISOCode: kCountriesCurrenciesList[3].currencyISOCode,
          currencyRate: 0,
          wasUpdated: false,
          wasRead: false,
        )
      ];

      List currenciesOnFistLoad = ["usd", "eur", "cad", "gbp"];
      bool currenciesRatesListWasUpdated = false;
      bool hasConnection = await connectionTest();

      if (hasConnection) {
        currenciesRatesListWasUpdated = await getCurrenciesRates();
      }

      if (currenciesRatesListWasUpdated) {
        for (int i = 0; i < 4; i++) {
          int currencyRateIndex = currenciesRatesList.indexWhere(
              (item) => item.currencyISOCode == currenciesOnFistLoad[i]);
          double currencyRate =
              currenciesRatesList[currencyRateIndex].currencyRate;

          if (i == 0) {
            baseSelectedCurrency.currencyRate = currencyRate;
            baseSelectedCurrency.wasUpdated = true;
          } else {
            selectedCurrenciesList[i - 1].currencyRate = currencyRate;
            selectedCurrenciesList[i - 1].wasUpdated = true;
          }
          selectedToDeleteCurrenciesList[i].currencyRate = currencyRate;
          selectedToDeleteCurrenciesList[i].wasUpdated = true;
          searchedToDeleteCurrenciesList[i].currencyRate = currencyRate;
          searchedToDeleteCurrenciesList[i].wasUpdated = true;
        }
      }
    }
    notifyListeners();
  }

  bool canUpdateRates() {
    if (selectedCurrenciesList.isNotEmpty ||
        baseSelectedCurrency.currencyName != '') {
      if (baseSelectedCurrency.currencyRate == 0 ||
          baseSelectedCurrency.currencyRate.isNaN ||
          baseSelectedCurrency.currencyRate.isInfinite) {
        return true;
      }
      for (int i = 0; i < selectedCurrenciesList.length; i++) {
        if (selectedCurrenciesList[i].currencyRate == 0 ||
            selectedCurrenciesList[i].currencyRate.isNaN ||
            selectedCurrenciesList[i].currencyRate.isInfinite) {
          return true;
        }
      }
    }

    if (lastUpdateTime == 0) {
      return true;
    } else {
      int now = DateTime.now().millisecondsSinceEpoch;
      if (now - lastUpdateTime > 3600000) {
        return true;
      }
    }

    return false;
  }
}
