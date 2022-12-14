import 'package:the_exchange_app/components/dialog_amount_base.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BaseSelectedCurrencyListTile extends StatelessWidget {
  const BaseSelectedCurrencyListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
        symbol: '',
        locale: Provider.of<ServicesProvider>(context).englishOption
            ? 'en_US'
            : 'es');

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
          Provider.of<ServicesProvider>(context).englishOption
              ? Provider.of<SelectedCurrenciesProvider>(context)
                  .baseSelectedCurrency
                  .currencyName
              : Provider.of<SelectedCurrenciesProvider>(context)
                  .baseSelectedCurrency
                  .nombreMoneda,
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          Provider.of<SelectedCurrenciesProvider>(context)
                      .baseSelectedCurrency
                      .currencyISOCode
                      .substring(0, 3) ==
                  'rv_'
              ? 'VES'
              : Provider.of<SelectedCurrenciesProvider>(context)
                          .baseSelectedCurrency
                          .currencyISOCode
                          .substring(0, 3) ==
                      'ra_'
                  ? 'ARS'
                  : Provider.of<SelectedCurrenciesProvider>(context)
                      .baseSelectedCurrency
                      .currencyISOCode
                      .toUpperCase(),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        trailing: GestureDetector(
          onTap: () {
            (!Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                            .baseSelectedCurrency
                            .wasRead &&
                        !Provider.of<SelectedCurrenciesProvider>(context,
                                listen: false)
                            .baseSelectedCurrency
                            .wasUpdated) ||
                    Provider.of<SelectedCurrenciesProvider>(context,
                                listen: false)
                            .baseSelectedCurrency
                            .currencyRate ==
                        0
                ? Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                    .showToastAlert(
                        Provider.of<ServicesProvider>(context).englishOption
                            ? kMessagePleaseUpdate
                            : kEsMessagePleaseUpdate,
                        Provider.of<ServicesProvider>(context, listen: false)
                                .darkThemeSelected
                            ? darkYellow
                            : darkGreen,
                        Theme.of(context).scaffoldBackgroundColor)
                : showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const DialogAmountBase());
          },
          child: Row(
            key: Provider.of<ServicesProvider>(context).keyCalculateBase,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                (!Provider.of<SelectedCurrenciesProvider>(context,
                                    listen: false)
                                .baseSelectedCurrency
                                .wasRead &&
                            !Provider.of<SelectedCurrenciesProvider>(context,
                                    listen: false)
                                .baseSelectedCurrency
                                .wasUpdated) ||
                        Provider.of<SelectedCurrenciesProvider>(context,
                                    listen: false)
                                .baseSelectedCurrency
                                .currencyRate ==
                            0
                    ? '${Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.currencyISOCode.substring(0, 3) == 'rv_' ? 'VES' : Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.currencyISOCode.substring(0, 3) == 'ra_' ? 'ARS' : Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.currencyISOCode.toUpperCase()} 0.00'
                    : '${Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.currencyISOCode.substring(0, 3) == 'rv_' ? 'VES' : Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.currencyISOCode.substring(0, 3) == 'ra_' ? 'ARS' : Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.currencyISOCode.toUpperCase()} ${currencyFormat.format((Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrencyAmount))}',
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
