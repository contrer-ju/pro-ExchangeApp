class CountryCurrency {
  final String countryName;
  final String countryISOCode;
  final String currencyName;
  final String currencyISOCode;
  final String region;
  late bool isChecked;
  final bool firstItem;

  CountryCurrency({
    required this.countryName,
    required this.countryISOCode,
    required this.currencyName,
    required this.currencyISOCode,
    required this.region,
    required this.isChecked,
    required this.firstItem,
  });
}

class CriptoCurrency {
  final String currencyName;
  final String currencyISOCode;
  late bool isChecked;

  CriptoCurrency({
    required this.currencyName,
    required this.currencyISOCode,
    required this.isChecked,
  });
}

class ReferenceCurrency {
  final String referenceName;
  final String referenceID;
  late bool isChecked;

  ReferenceCurrency({
    required this.referenceName,
    required this.referenceID,
    required this.isChecked,
  });
}

class SelectedCurrencies {
  late String imageID;
  late String currencyName;
  late String currencyISOCode;
  late double currencyRate;

  SelectedCurrencies({
    required this.imageID,
    required this.currencyName,
    required this.currencyISOCode,
    required this.currencyRate,
  });
}

class CurrenciesRates {
  late String currencyISOCode;
  late double currencyRate;

  CurrenciesRates({
    required this.currencyISOCode,
    required this.currencyRate,
  });
}
