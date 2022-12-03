class CountryCurrency {
  final String countryName;
  final String pais;
  final String countryISOCode;
  final String currencyName;
  final String moneda;
  final String currencyISOCode;
  final String region;
  final String zona;
  late bool isChecked;
  final bool firstItem;

  CountryCurrency({
    required this.countryName,
    required this.pais,
    required this.countryISOCode,
    required this.currencyName,
    required this.moneda,
    required this.currencyISOCode,
    required this.region,
    required this.zona,
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
  final String nombreReferencia;
  final String referenceID;
  final String country;
  final String pais;
  late bool isChecked;

  ReferenceCurrency({
    required this.referenceName,
    required this.nombreReferencia,
    required this.referenceID,
    required this.country,
    required this.pais,
    required this.isChecked,
  });
}

class SelectedCurrencies {
  late String imageID;
  late String currencyName;
  late String nombreMoneda;
  late String currencyISOCode;
  late double currencyRate;
  late bool wasUpdated;
  late bool wasRead;

  SelectedCurrencies({
    required this.imageID,
    required this.currencyName,
    required this.nombreMoneda,
    required this.currencyISOCode,
    required this.currencyRate,
    required this.wasUpdated,
    required this.wasRead,
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
