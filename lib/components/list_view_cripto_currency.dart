import 'package:the_exchange_app/components/list_tile_cripto_currency.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/provider/cripto_currencies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_exchange_app/provider/theme_provider.dart';

class CriptoCurrencyListView extends StatelessWidget {
  const CriptoCurrencyListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<CriptoCurrenciesProvider>(context)
            .criptoCurrenciesSearchList
            .isEmpty
        ? Center(
            child: Text(
            Provider.of<ThemeProvider>(context).englishOption
                ? kSearchNoResult
                : kEsSearchNoResult,
            style: Theme.of(context).textTheme.headline5,
          ))
        : ListView.builder(
            controller: ScrollController(),
            itemCount: Provider.of<CriptoCurrenciesProvider>(context)
                .criptoCurrenciesSearchList
                .length,
            itemBuilder: (context, index) => CriptoCurrencyListTile(
                  currencyName: Provider.of<CriptoCurrenciesProvider>(context)
                      .criptoCurrenciesSearchList[index]
                      .currencyName,
                  currencyISOCode:
                      Provider.of<CriptoCurrenciesProvider>(context)
                          .criptoCurrenciesSearchList[index]
                          .currencyISOCode,
                  isChecked: Provider.of<CriptoCurrenciesProvider>(context)
                      .criptoCurrenciesSearchList[index]
                      .isChecked,
                ));
  }
}
