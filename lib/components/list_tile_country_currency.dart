import 'package:the_exchange_app/provider/countries_currencies_provider.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:the_exchange_app/provider/selected_currencies_rates_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryCurrencyListTile extends StatelessWidget {
  final String countryName;
  final String countryISOCode;
  final String currencyName;
  final String currencyISOCode;
  final bool isChecked;

  const CountryCurrencyListTile({
    Key? key,
    required this.countryName,
    required this.countryISOCode,
    required this.currencyName,
    required this.currencyISOCode,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currencyRateIndex =
        Provider.of<SelectedCurrenciesRatesProvider>(context, listen: false)
            .selectedCurrenciesRatesList
            .indexWhere((item) => item.currencyISOCode == currencyISOCode);
    final double currencyRate =
        Provider.of<SelectedCurrenciesRatesProvider>(context, listen: false)
            .selectedCurrenciesRatesList[currencyRateIndex]
            .currencyRate;

    return Card(
      elevation: kElevationCurrencyCard,
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kMainCardBorderRadius),
          borderSide:
              const BorderSide(color: darkWhite, width: kMainCardBorderWidth)),
      child: ListTile(
        leading: Image(
          width: kFlagImageWidth,
          height: kFlagImageHeight,
          image: AssetImage('images/$countryISOCode.png'),
        ),
        title: Text(
          countryName,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          '$currencyName (${currencyISOCode.toUpperCase()})',
          style: Theme.of(context).textTheme.headline4,
        ),
        trailing: Checkbox(
          activeColor: Theme.of(context).scaffoldBackgroundColor,
          checkColor: Theme.of(context).primaryColor,
          value: isChecked,
          onChanged: (bool? value) {
            Provider.of<CountriesCurrenciesProvider>(context, listen: false)
                .toggleCheckboxOfCurrency(currencyISOCode);
            if (isChecked) {
              Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                  .deletedCurrencyFromList(currencyISOCode);
            } else {
              Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                  .addCurrencyToList(countryISOCode, currencyName,
                      currencyISOCode, currencyRate);
            }
          },
        ),
      ),
    );
  }
}
