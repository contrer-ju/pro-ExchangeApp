import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_exchange_app/constants/currencies_rates.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:the_exchange_app/models/currencies_box.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class CurrenciesRatesProvider extends ChangeNotifier {
  final boxCurrenciesRateList =
      Hive.box<CurrenciesRatesBox>('currenciesRatesBox');
  List currenciesRatesList = kCurrenciesRatesList;

  void getCurrenciesRates() async {
    List currenciesRatesData = [];
    CollectionReference ratesCollection =
        FirebaseFirestore.instance.collection("rates");
    QuerySnapshot rates = await ratesCollection.get();

    if (rates.docs.isNotEmpty) {
      for (var doc in rates.docs) {
        currenciesRatesData.add(doc.data());
      }
    }

    if (currenciesRatesData.isNotEmpty) {
      currenciesRatesList = [];
      boxCurrenciesRateList.clear();
      for (int i = 0; i < currenciesRatesData.length; i++) {
        CurrenciesRates currenciesRateValue = CurrenciesRates(
            currencyISOCode: currenciesRatesData[i]['currencyISOCode'],
            currencyRate: currenciesRatesData[i]['currencyRate'].toDouble());
        currenciesRatesList.add(currenciesRateValue);
        
        boxCurrenciesRateList.add(CurrenciesRatesBox(
          currencyISOCode: currenciesRatesData[i]['currencyISOCode'],
          currencyRate: currenciesRatesData[i]['currencyRate'].toDouble(),
        ));
      }
    }
    notifyListeners();
  }
}
