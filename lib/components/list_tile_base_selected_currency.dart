import 'package:the_exchange_app/components/dialog_amount.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BaseSelectedCurrencyListTile extends StatelessWidget {
  BaseSelectedCurrencyListTile({
    Key? key,
  }) : super(key: key);

  final currencyAmountFormat = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kElevationCurrencyCard,
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kMainCardBorderRadius),
          borderSide:
              const BorderSide(color: darkGreen, width: kMainCardBorderWidth)),
      child: ListTile(
        leading: Image(
          width: kFlagImageWidth,
          height: kFlagImageHeight,
          image: AssetImage(
              'images/${Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.imageID}.png'),
        ),
        title: Text(
          Provider.of<SelectedCurrenciesProvider>(context)
              .baseSelectedCurrency
              .currencyName,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          Provider.of<SelectedCurrenciesProvider>(context)
              .baseSelectedCurrency
              .currencyISOCode
              .toUpperCase(),
          style: Theme.of(context).textTheme.headline4,
        ),
        trailing: GestureDetector(
          onTap: () {
            showDialog(context: context, builder: (_) => const DialogAmount());
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.currencyISOCode.toUpperCase()} ${currencyAmountFormat.format((Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrencyAmount))}',
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: kPaddingLeftReorderableDrag,
                    right: kPaddingRightReorderableDrag),
                child: Icon(
                  Icons.calculate,
                  size: kIconsSizes,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
