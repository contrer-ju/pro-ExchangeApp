import 'package:the_exchange_app/components/list_tile_country_currency.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/countries_currencies_provider.dart';
import 'package:the_exchange_app/services/theme_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryCurrencyListView extends StatelessWidget {
  const CountryCurrencyListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<CountriesCurrenciesProvider>(context)
            .countryCurrenciesSearchList
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
            itemCount: Provider.of<CountriesCurrenciesProvider>(context)
                .countryCurrenciesSearchList
                .length,
            itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Provider.of<CountriesCurrenciesProvider>(context)
                                .countryCurrenciesSearchList[index]
                                .firstItem &&
                            Provider.of<CountriesCurrenciesProvider>(context)
                                    .countryCurrenciesSearchList[index]
                                    .region !=
                                Provider.of<CountriesCurrenciesProvider>(
                                        context)
                                    .countryCurrenciesSearchList[0]
                                    .region
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: kVerticalPaddingTitleTile,
                                bottom: kVerticalPaddingTitleTile,
                                left: kHorizantalPaddingTitleTile),
                            child: Text(
                              Provider.of<CountriesCurrenciesProvider>(context)
                                  .countryCurrenciesSearchList[index]
                                  .region,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          )
                        : const SizedBox.shrink(),
                    CountryCurrencyListTile(
                      countryName:
                          Provider.of<CountriesCurrenciesProvider>(context)
                              .countryCurrenciesSearchList[index]
                              .countryName,
                      nombrePais:
                          Provider.of<CountriesCurrenciesProvider>(context)
                              .countryCurrenciesSearchList[index]
                              .pais,
                      countryISOCode:
                          Provider.of<CountriesCurrenciesProvider>(context)
                              .countryCurrenciesSearchList[index]
                              .countryISOCode,
                      currencyName:
                          Provider.of<CountriesCurrenciesProvider>(context)
                              .countryCurrenciesSearchList[index]
                              .currencyName,
                      nombreMoneda:
                          Provider.of<CountriesCurrenciesProvider>(context)
                              .countryCurrenciesSearchList[index]
                              .moneda,
                      currencyISOCode:
                          Provider.of<CountriesCurrenciesProvider>(context)
                              .countryCurrenciesSearchList[index]
                              .currencyISOCode,
                      isChecked:
                          Provider.of<CountriesCurrenciesProvider>(context)
                              .countryCurrenciesSearchList[index]
                              .isChecked,
                    ),
                  ],
                ));
  }
}
