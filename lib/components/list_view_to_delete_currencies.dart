import 'package:the_exchange_app/components/list_tile_to_delete_currency.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteSelectedCurrencyListView extends StatelessWidget {
  const DeleteSelectedCurrencyListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<SelectedCurrenciesProvider>(context)
            .searchedToDeleteCurrenciesList
            .isEmpty
        ? Center(
            child: Text(
            Provider.of<SelectedCurrenciesProvider>(context)
                    .selectedCurrenciesList
                    .isEmpty
                ? kNothingToUpdate
                : kSearchNoResult,
            style: Theme.of(context).textTheme.headline5,
          ))
        : ListView.builder(
            controller: ScrollController(),
            itemCount: Provider.of<SelectedCurrenciesProvider>(context)
                .searchedToDeleteCurrenciesList
                .length,
            itemBuilder: (context, index) => DeleteSelectedCurrencyListTile(
                  imageID: Provider.of<SelectedCurrenciesProvider>(context)
                      .searchedToDeleteCurrenciesList[index]
                      .imageID,
                  currencyName: Provider.of<SelectedCurrenciesProvider>(context)
                      .searchedToDeleteCurrenciesList[index]
                      .currencyName,
                  currencyISOCode:
                      Provider.of<SelectedCurrenciesProvider>(context)
                          .searchedToDeleteCurrenciesList[index]
                          .currencyISOCode,
                ));
  }
}
