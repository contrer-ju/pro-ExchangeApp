import 'package:the_exchange_app/components/list_tile_reference_currency.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/provider/references_currencies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferenceCurrencyListView extends StatelessWidget {
  const ReferenceCurrencyListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<ReferenceCurrenciesProvider>(context)
            .referencesCurrenciesSearchList
            .isEmpty
        ? Center(
            child: Text(
            kSearchNoResult,
            style: Theme.of(context).textTheme.headline5,
          ))
        : ListView.builder(
            controller: ScrollController(),
            itemCount: Provider.of<ReferenceCurrenciesProvider>(context)
                .referencesCurrenciesSearchList
                .length,
            itemBuilder: (context, index) => ReferenceCurrencyListTile(
                  referenceName:
                      Provider.of<ReferenceCurrenciesProvider>(context)
                          .referencesCurrenciesSearchList[index]
                          .referenceName,
                  referenceID: Provider.of<ReferenceCurrenciesProvider>(context)
                      .referencesCurrenciesSearchList[index]
                      .referenceID,
                  country: Provider.of<ReferenceCurrenciesProvider>(context)
                      .referencesCurrenciesSearchList[index]
                      .country,
                  isChecked: Provider.of<ReferenceCurrenciesProvider>(context)
                      .referencesCurrenciesSearchList[index]
                      .isChecked,
                ));
  }
}
