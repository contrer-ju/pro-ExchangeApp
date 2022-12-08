import 'package:the_exchange_app/services/cripto_currencies_provider.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CriptoCurrencyListTile extends StatelessWidget {
  final String currencyName;
  final String currencyISOCode;
  final bool isChecked;

  const CriptoCurrencyListTile({
    Key? key,
    required this.currencyName,
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
          image: AssetImage('images/$currencyISOCode.png'),
        ),
        title: Text(
          currencyName,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          currencyISOCode.toUpperCase(),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        trailing: Checkbox(
          activeColor: Theme.of(context).scaffoldBackgroundColor,
          checkColor: Theme.of(context).primaryColor,
          value: isChecked,
          onChanged: (bool? value) {
            Provider.of<CriptoCurrenciesProvider>(context, listen: false)
                .toggleCheckboxOfCurrency(currencyISOCode);
            if (isChecked) {
              Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                  .deletedCurrencyFromList(currencyISOCode);
            } else {
              Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                  .addCurrencyToList(currencyISOCode, currencyName,
                      currencyName, currencyISOCode);
            }
          },
        ),
      ),
    );
  }
}
