import 'package:the_exchange_app/constants/currencies_rates.dart';
import 'package:the_exchange_app/models/currencies.dart';
import 'package:flutter/foundation.dart';

class SelectedCurrenciesRatesProvider extends ChangeNotifier {
  List<CurrenciesRates> selectedCurrenciesRatesList = kCurrenciesRatesList;
}
