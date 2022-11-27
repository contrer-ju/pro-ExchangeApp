import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAmount extends StatelessWidget {
  const DialogAmount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String newStringValue = '';
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        kTitleDialog,
        style: Theme.of(context).textTheme.headline1,
      ),
      content: TextField(
        autofocus: true,
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: false),
        inputFormatters: [
          CurrencyTextInputFormatter(
            decimalDigits: 2,
            symbol:
                "${Provider.of<SelectedCurrenciesProvider>(context).baseSelectedCurrency.currencyISOCode.toUpperCase()} ",
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
          newStringValue = stringValue;
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (newStringValue != '') {
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
                      .setBaseSelectedCurrencyAmount(
                          double.parse(filterStringValue));
                }
              }
              Navigator.of(context).pop();
            },
            child: Text(
              kSubmitButton,
              style: Theme.of(context).textTheme.headline2,
            ))
      ],
    );
  }
}