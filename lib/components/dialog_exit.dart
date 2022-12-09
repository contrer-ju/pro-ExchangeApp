import 'package:the_exchange_app/components/ad_dialog_container.dart';
import 'package:the_exchange_app/constants/strings.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_exchange_app/style/theme.dart';

class DialogExit extends StatelessWidget {
  const DialogExit({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  // void deleteBoxes() async {
  //   await Hive.deleteBoxFromDisk('selectedCurrenciesBox');
  //   await Hive.deleteBoxFromDisk('selectedCurrenciesListBox');
  //   await Hive.deleteBoxFromDisk('currenciesRatesBox');
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          Provider.of<ServicesProvider>(context).englishOption
              ? kDialogQuestion
              : kEsDialogQuestion,
          style: Theme.of(context).textTheme.headline1,
        ),
        content: const AdDialogContainer(),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              Provider.of<ServicesProvider>(context).englishOption
                  ? kDialogStay
                  : kEsDialogStay,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(
            width: kSecondarySpace,
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                  .saveBaseSelectedCurrencyAmount();
              Provider.of<SelectedCurrenciesProvider>(context, listen: false)
                  .saveCurrenciesList();
              Provider.of<ServicesProvider>(context, listen: false).saveTheme();
              Provider.of<ServicesProvider>(context, listen: false).saveLanguage();
              Navigator.of(context).pop(true);
            },
            child: Text(
              Provider.of<ServicesProvider>(context).englishOption
                  ? kDialogExit
                  : kEsDialogExit,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
