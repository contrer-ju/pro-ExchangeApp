import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:hive/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_exchange_app/constants/currencies_rates.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:the_exchange_app/models/currencies_box.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';

class CurrenciesRatesProvider extends ChangeNotifier {
  bool ratesUpdated = false;
  bool ratesRead = false;
  final boxCurrenciesRateList =
      Hive.box<CurrenciesRatesBox>('currenciesRatesBox');
  List currenciesRatesList = kCurrenciesRatesList;

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

  Future<bool> readFirestore() async {
    List currenciesRatesData = [];
    CollectionReference ratesCollection =
        FirebaseFirestore.instance.collection("rates");
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
              currencyRate: currenciesRatesData[i]['currencyRate'].toDouble());
          currenciesRatesList.add(currenciesRateValue);
        }
        saveCurrenciesRates();
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  void readLocalStorage() {
    currenciesRatesList = [];
    for (int i = 0; i < boxCurrenciesRateList.length; i++) {
      final storedCurrencyRate = boxCurrenciesRateList.getAt(i);
      CurrenciesRates currencyRateToAdd = CurrenciesRates(
          currencyISOCode: storedCurrencyRate!.currencyISOCode,
          currencyRate: storedCurrencyRate.currencyRate);
      currenciesRatesList.add(currencyRateToAdd);
    }
    notifyListeners();
  }

  void saveCurrenciesRates() {
    if (currenciesRatesList.isNotEmpty && ratesUpdated && !ratesRead) {
      for (int i = 0; i < boxCurrenciesRateList.length; i++) {
        boxCurrenciesRateList.deleteAt(i);
      }
      for (int j = 0; j < currenciesRatesList.length; j++) {
        boxCurrenciesRateList.add(CurrenciesRatesBox(
          currencyISOCode: currenciesRatesList[j].currencyISOCode,
          currencyRate: currenciesRatesList[j].currencyRate,
        ));
      }
    }
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

  void getCurrenciesRates(Color bColor, Color tColor) async {
    bool hasConnection = await connectionTest();
    if (hasConnection) {
      bool wasReadFirestore = await readFirestore();
      if (wasReadFirestore) {
        showToastAlert(kMessageUpdateTrue, bColor, tColor);
        ratesUpdated = true;
      } else {
        showToastAlert(kMessageUpdateFail, bColor, tColor);
      }
    } else {
      if (boxCurrenciesRateList.length == kCurrenciesRatesList.length) {
        readLocalStorage();
        showToastAlert(kMessageStorageTrue, bColor, tColor);
        ratesRead = true;
      } else {
        showToastAlert(kMessageUpdateFail, bColor, tColor);
        ratesUpdated = false;
        ratesRead = false;
      }
    }
    notifyListeners();
  }
}
