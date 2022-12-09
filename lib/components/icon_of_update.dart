import 'package:provider/provider.dart';
import 'package:the_exchange_app/services/selected_currencies_provider.dart';
import 'package:the_exchange_app/services/services_provider.dart';
import 'package:the_exchange_app/style/theme.dart';
import 'package:flutter/material.dart';

class UpdateIcon extends StatelessWidget {
  const UpdateIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        Provider.of<ServicesProvider>(context, listen: false).darkThemeSelected
            ? darkYellow
            : darkGreen;
    Color textColor = Theme.of(context).scaffoldBackgroundColor;
    bool isEnglish = Provider.of<ServicesProvider>(context).englishOption;

    return IconButton(
      key: Provider.of<ServicesProvider>(context).keyUpdateButton,
      icon: Icon(
        Provider.of<SelectedCurrenciesProvider>(context)
                    .baseSelectedCurrency
                    .currencyName ==
                ''
            ? Icons.update_disabled
            : Provider.of<SelectedCurrenciesProvider>(context).isUpdating
                ? Icons.lock_clock
                : Icons.update,
        size: kIconsSizes,
        color: darkWhite,
      ),
      onPressed: () {
        if (!Provider.of<SelectedCurrenciesProvider>(context, listen: false)
            .isUpdating) {
          Provider.of<SelectedCurrenciesProvider>(context, listen: false)
              .setTrueIsUpdating();
          Provider.of<SelectedCurrenciesProvider>(context, listen: false)
              .updateRatesCurrenciesList(backgroundColor, textColor, isEnglish);
        }
      },
    );
  }
}
