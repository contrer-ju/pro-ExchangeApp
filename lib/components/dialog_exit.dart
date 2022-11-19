import 'package:the_exchange_app/components/ad_dialog_container.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/provider/selected_currencies_provider.dart';
import 'package:the_exchange_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogExit extends StatelessWidget {
  const DialogExit({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        kDialogQuestion,
        style: Theme.of(context).textTheme.headline1,
      ),
      content: const AdDialogContainer(),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            kDialogStay,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        TextButton(
          onPressed: () {
            Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                .saveCurrenciesList();
            Provider.of<ThemeProvider>(context, listen: false).saveTheme();
            Navigator.of(context).pop(true);
          },
          child: Text(
            kDialogExit,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ],
    );
  }
}
