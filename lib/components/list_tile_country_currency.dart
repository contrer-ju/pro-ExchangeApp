import 'package:the_exchange_app/services/countries_currencies_provider.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryCurrencyListTile extends StatelessWidget {
  final String countryName;
  final String nombrePais;
  final String countryISOCode;
  final String currencyName;
  final String nombreMoneda;
  final String currencyISOCode;
  final bool isChecked;

  const CountryCurrencyListTile({
    Key? key,
    required this.countryName,
    required this.nombrePais,
    required this.countryISOCode,
    required this.currencyName,
    required this.nombreMoneda,
    required this.currencyISOCode,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Provider.of<ServicesProvider>(context).englishOption
              ? countryName
              : nombrePais,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          Provider.of<ServicesProvider>(context).englishOption
              ? currencyISOCode.substring(0, 3) == 'ra_'
                  ? '$currencyName (ARS)'
                  : '$currencyName (${currencyISOCode.toUpperCase()})'
              : currencyISOCode.substring(0, 3) == 'ra_'
                  ? '$nombreMoneda (ARS)'
                  : '$nombreMoneda (${currencyISOCode.toUpperCase()})',
          style: Theme.of(context).textTheme.subtitle2,
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
                  .addCurrencyToList(countryISOCode, currencyName, nombreMoneda,
                      currencyISOCode);
            }
          },
        ),
      ),
    );
  }
}
