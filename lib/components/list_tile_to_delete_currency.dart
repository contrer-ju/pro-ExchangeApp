import 'package:the_exchange_app/provider/countries_currencies_provider.dart';
import 'package:the_exchange_app/provider/cripto_currencies_provider.dart';
import 'package:the_exchange_app/provider/references_currencies_provider.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteSelectedCurrencyListTile extends StatelessWidget {
  final String imageID;
  final String currencyName;
  final String currencyISOCode;

  const DeleteSelectedCurrencyListTile({
    Key? key,
    required this.imageID,
    required this.currencyName,
    required this.currencyISOCode,
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
          image: AssetImage('images/$imageID.png'),
        ),
        title: Text(
          currencyName,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          currencyISOCode.toUpperCase(),
          style: Theme.of(context).textTheme.headline4,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            size: kIconsSizes,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                .deletedCurrencyFromList(currencyISOCode);
            Provider.of<CountriesCurrenciesProvider>(context, listen: false)
                .toggleCheckboxOfCurrency(currencyISOCode);
            Provider.of<CriptoCurrenciesProvider>(context, listen: false)
                .toggleCheckboxOfCurrency(currencyISOCode);
            Provider.of<ReferenceCurrenciesProvider>(context, listen: false)
                .toggleCheckboxOfCurrency(currencyISOCode);
          },
        ),
      ),
    );
  }
}
