import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_exchange_app/style/theme.dart';

class DialogAmountList extends StatefulWidget {
  final String currencyID;
  final double enteredAmount;

  const DialogAmountList({
    Key? key,
    required this.currencyID,
    required this.enteredAmount,
  }) : super(key: key);

  @override
  State<DialogAmountList> createState() => _DialogAmountListState();
}

class _DialogAmountListState extends State<DialogAmountList> {
  String newStringValue = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          Provider.of<ServicesProvider>(context).englishOption
              ? kTitleDialog
              : kEsTitleDialog,
          style: Theme.of(context).textTheme.headline1,
        ),
        content: TextField(
          autofocus: true,
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: false),
          inputFormatters: [
            CurrencyTextInputFormatter(
              decimalDigits: 2,
              symbol: Provider.of<SelectedCurrenciesProvider>(context)
                          .baseSelectedCurrency
                          .currencyISOCode
                          .substring(0, 3) ==
                      'rv_'
                  ? 'VES '
                  : Provider.of<SelectedCurrenciesProvider>(context)
                              .baseSelectedCurrency
                              .currencyISOCode
                              .substring(0, 3) ==
                          'ra_'
                      ? 'ARS '
                      : "${Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.currencyISOCode.toUpperCase()} ",
            )
          ],
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          onChanged: (stringValue) {
            setState(() {
              newStringValue = stringValue;
            });
          },
        ),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                Provider.of<ServicesProvider>(context).englishOption
                    ? kBottomSheetCancel
                    : kEsBottomSheetCancel,
                style: Theme.of(context).textTheme.headline6,
              )),
          const SizedBox(width: 25),
          ElevatedButton(
              onPressed: newStringValue == ''
                  ? null
                  : () {
                      List<String> listStringValue = [];
                      for (var x in newStringValue.runes) {
                        var char = String.fromCharCode(x);
                        if (char == '0' ||
                            char == '1' ||
                            char == '2' ||
                            char == '3' ||
                            char == '4' ||
                            char == '5' ||
                            char == '6' ||
                            char == '7' ||
                            char == '8' ||
                            char == '9' ||
                            char == '.') {
                          listStringValue.add(char);
                        }
                      }
                      String filterStringValue = listStringValue.join();
                      if (filterStringValue != '') {
                        Provider.of<SelectedCurrenciesProvider>(context,
                                listen: false)
                            .setBaseSelectedCurrency(widget.currencyID,
                                double.parse(filterStringValue));
                      }
                      Navigator.of(context).pop();
                    },
              child: Text(
                Provider.of<ServicesProvider>(context).englishOption
                    ? kSubmitButton
                    : kEsSubmitButton,
                style:
                    Provider.of<ServicesProvider>(context).darkThemeSelected &&
                            newStringValue == ''
                        ? Theme.of(context).textTheme.headline6!.copyWith(
                              color: darkDropdown,
                            )
                        : Theme.of(context).textTheme.headline6,
              ))
        ],
      ),
    );
  }
}
